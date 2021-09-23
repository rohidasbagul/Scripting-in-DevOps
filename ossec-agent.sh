#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL
 
if [ -f /etc/debian_version ]; then
    sudo apt-get install unzip -y
elif [ -f /etc/redhat-release ]; then
    sudo yum install unzip -y
fi
echo "Downloading OSSEC packages"
cd /opt && sudo wget https://s3.amazonaws.com/ossec-data/ossec-preconf.zip	
echo "Extracting OSSEC packages"
sudo unzip ossec-preconf.zip
cd ossec-hids-2.8.3
echo "Installing OSSEC packages"
sudo bash install.sh