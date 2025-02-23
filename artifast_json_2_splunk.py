#!/usr/bin/env python3
import glob
import re

def process_file(filename):
    # Open the file without converting newlines.
    with open(filename, 'r', encoding='utf-8', newline='') as f:
        content = f.read()

    # Apply substitutions
    content = re.sub(r'\[', '', content)                      # remove '['
    content = re.sub(r'\]', '', content)                      # remove ']'
    content = re.sub(r' {', '{', content)                      # replace " {" with "{"
    content = re.sub(r'},\{', '}\r\n{', content)              # replace "},{" with "}\r\n{"
    content = re.sub(r'\{\r\n\s+', '{', content)              # remove newline and spaces after '{'
    content = re.sub(r',\r\n\s+', ',', content)               # remove newline and spaces after comma
    content = re.sub(r'\r\n\s+\}', '}', content)              # remove newline and spaces before '}'
    content = re.sub(r'\r\n\}', '}', content)                 # remove newline before '}'

    # Write back, preserving the newline sequences
    with open(filename, 'w', encoding='utf-8', newline='') as f:
        f.write(content)

def main():
    files = glob.glob('*.json')
    total = len(files)
    for idx, filename in enumerate(files, start=1):
        print(f"Processing file {idx}/{total}: {filename}")
        process_file(filename)

if __name__ == '__main__':
    main()
