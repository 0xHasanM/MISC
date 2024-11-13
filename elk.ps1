$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.16.0-windows-x86_64.zip -OutFile elastic-agent-8.16.0-windows-x86_64.zip 
Expand-Archive .\elastic-agent-8.16.0-windows-x86_64.zip -DestinationPath .
cd elastic-agent-8.16.0-windows-x86_64
.\elastic-agent.exe install --url=https://172.168.40.123:8220 --enrollment-token=QkdVNUo1TUJrbUdRVG9VQUVDUG86cVlMQlFyZDVRY09SdHRCbW1LREZjQQ==
