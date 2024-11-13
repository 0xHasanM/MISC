curl -L -O https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.16.0-linux-x86_64.tar.gz 
tar xzvf elastic-agent-8.16.0-linux-x86_64.tar.gz
cd elastic-agent-8.16.0-linux-x86_64
sudo ./elastic-agent install --url=https://172.168.40.123:8220 --enrollment-token=QkdVNUo1TUJrbUdRVG9VQUVDUG86cVlMQlFyZDVRY09SdHRCbW1LREZjQQ==
