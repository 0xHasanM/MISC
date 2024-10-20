#!/bin/bash

# -------------------------------------------------------------------
# Script Name: asset_discovery.sh
# Description: Performs a ping sweep on a /16 CIDR network range
#              based on the machine's primary IP address. It identifies
#              active hosts, attempts to determine their operating systems,
#              and retrieves their hostnames.
# Author: mhasan
# Date: 20/0/2024
# -------------------------------------------------------------------

# Maximum number of concurrent processes to control parallelism
MAX_CONCURRENT=50

# -------------------------------------------------------------------
# Function: get_primary_ip
# Description: Retrieves the machine's primary IPv4 address by checking
#              available network commands ('ip' or 'ifconfig').
#              Exits the script if neither command is available.
# -------------------------------------------------------------------
get_primary_ip() {
    # Check if the 'ip' command is available
    if command -v ip &>/dev/null; then
        # Use the 'ip' command to list IPv4 addresses, exclude the 'lo' interface
        ip -o -4 addr list scope global up | awk '$2 != "lo" {print $4}' | cut -d/ -f1 | head -n1
    elif command -v ifconfig &>/dev/null; then
        # Fallback to 'ifconfig' if 'ip' is not available
        # Extract lines containing 'inet', exclude the loopback address, and select the first IP
        ifconfig | awk '/inet / && !/127.0.0.1/ {print $2}' | head -n1
    else
        # Output an error message to stderr and exit if neither command is found
        echo "Neither 'ip' nor 'ifconfig' command is available." >&2
        exit 1
    fi
}

# -------------------------------------------------------------------
# Function: get_ttl
# Description: Extracts the TTL (Time To Live) value from the ping output.
# Parameters:
#   $1 - The output string from the ping command.
# Returns:
#   The TTL value as an integer, or an empty string if not found.
# -------------------------------------------------------------------
get_ttl() {
    local ping_output="$1"
    # Use 'sed' with extended regex to capture the TTL value
    echo "$ping_output" | sed -nE 's/.*ttl=([0-9]+).*/\1/p'
}

# -------------------------------------------------------------------
# Function: determine_os
# Description: Infers the operating system of a host based on its TTL value
#              and the presence of specific open ports.
# Parameters:
#   $1 - The IP address of the host.
#   $2 - The TTL value extracted from the ping output (can be empty).
#   $@ - The list of open ports.
# Returns:
#   A string representing the inferred operating system.
# -------------------------------------------------------------------
determine_os() {
    local ip="$1"
    local ttl="$2"
    shift 2
    local open_ports=("$@")
    local os="Unknown"

    # Infer OS based on TTL value if TTL is available
    if [ -n "$ttl" ]; then
        if [ "$ttl" -le 64 ]; then
            os="Linux/Unix"
        elif [ "$ttl" -le 128 ]; then
            os="Windows"
        elif [ "$ttl" -le 255 ]; then
            os="Network Device"
        fi
    fi

    # Define port-to-OS mappings
    declare -A port_os_mapping=(
        [22]="Linux/Unix"
        [135]="Windows"
        [139]="Windows"
        [445]="Windows"
        [3389]="Windows"
    )

    # Refine OS detection based on open ports
    for port in "${open_ports[@]}"; do
        if [ -n "${port_os_mapping[$port]}" ]; then
            os="${port_os_mapping[$port]}"
            break
        fi
    done

    echo "$os"
}

# -------------------------------------------------------------------
# Function: get_hostname
# Description: Retrieves the hostname associated with a given IP address
#              using DNS reverse lookup via 'nslookup'.
# Parameters:
#   $1 - The IP address to lookup.
# Returns:
#   The hostname if found, otherwise "N/A".
# -------------------------------------------------------------------
get_hostname() {
    local ip="$1"
    local hostname

    # Perform nslookup and extract the hostname from the output
    hostname=$(nslookup "$ip" 2>/dev/null | awk -F " " '/name =/ {print $NF}' | sed 's/\.$//' | cut -d "." -f1)

    # If no hostname is found, set it to "N/A"
    if [ -z "$hostname" ]; then
        hostname="N/A"
    fi

    echo "$hostname"
}

# -------------------------------------------------------------------
# Function: process_ip
# Description: Processes a single IP address by performing a ping,
#              scanning ports, extracting the TTL, determining the OS,
#              and retrieving the hostname. Outputs the result in CSV format.
# Parameters:
#   $1 - The IP address to process.
# Outputs:
#   A comma-separated string: IP,Hostname,OS
# -------------------------------------------------------------------
process_ip() {
    local ip="$1"

    # Perform a single ICMP ping with a 1-second timeout and capture the output
    local ping_output
    ping_output=$(ping -c1 -W1 "$ip" 2>/dev/null)

    local ttl=""
    local machine_up=false

    # Check if the ping was successful by searching for "bytes from" in the output
    if echo "$ping_output" | grep -q "bytes from"; then
        # Extract the TTL value from the ping output
        ttl=$(get_ttl "$ping_output")
        machine_up=true
    fi

    # Ports to scan
    local ports_to_scan=(22 135 139 445 3389)
    local open_ports=()

    # Scan ports
    for port in "${ports_to_scan[@]}"; do
        if timeout 0.1 bash -c "echo > /dev/tcp/$ip/$port" 2>/dev/null; then
            open_ports+=("$port")
        fi
    done

    # If ping failed but any ports are open, consider the machine up
    if [ "$machine_up" = false ] && [ "${#open_ports[@]}" -gt 0 ]; then
        machine_up=true
    fi

    if [ "$machine_up" = true ]; then
        # Determine the operating system based on TTL and open ports
        local os
        os=$(determine_os "$ip" "$ttl" "${open_ports[@]}")

        # Retrieve the hostname associated with the IP
        local hostname
        hostname=$(get_hostname "$ip")

        # Output the results in CSV format: IP,Hostname,OS
        echo "$ip,$hostname,$os"
    fi
}

# -------------------------------------------------------------------
# Function: ping_sweep
# Description: Performs a parallelized ping sweep across a /16 network range.
#              Limits the number of concurrent background jobs to prevent
#              system overload.
# Parameters:
#   $1 - The first octet of the IP range.
#   $2 - The second octet of the IP range.
# -------------------------------------------------------------------
ping_sweep() {
    local octet1="$1"
    local octet2="$2"
    local max_jobs="$MAX_CONCURRENT"  # Maximum concurrent processes
    local job_count=0                 # Current number of active jobs

    # Iterate through the third octet (0 to 255)
    for octet3 in {0..255}; do
        # Iterate through the fourth octet (1 to 254) to avoid network and broadcast addresses
        for octet4 in {1..254}; do
            # Construct the full IP address
            ip="$octet1.$octet2.$octet3.$octet4"
            (
                # Process the IP address in a subshell to enable parallel execution
                process_ip "$ip"
            ) &  # Run the subshell in the background

            # Increment the job counter
            ((job_count++))

            # If the maximum number of concurrent jobs is reached, wait for any to finish
            if [ "$job_count" -ge "$max_jobs" ]; then
                # 'wait -n' waits for the next background job to finish
                wait -n 2>/dev/null
                # Decrement the job counter as one job has completed
                ((job_count--))
            fi
        done
    done

    # Wait for all remaining background jobs to complete before exiting the function
    wait
}

# -------------------------------------------------------------------
# Main Execution Block
# -------------------------------------------------------------------

# Retrieve the primary IP address of the machine
primary_ip=$(get_primary_ip)

# Check if the primary IP was successfully obtained
if [ -z "$primary_ip" ]; then
    echo "Unable to determine the machine's IP address." >&2
    exit 1
fi

# Extract the first two octets of the IP address to define the /16 network range
# The 'IFS=.' sets the Internal Field Separator to a dot for splitting
IFS=. read -r octet1 octet2 _ _ <<< "$primary_ip"

# Initiate the ping sweep on the determined /16 network range
ping_sweep "$octet1" "$octet2"
