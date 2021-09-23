#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL


echo "Installation Rundeck start..."
sudo apt-get -y install openjdk-7-jre 
cd /opt && wget http://dl.bintray.com/rundeck/rundeck-deb/rundeck-2.6.2-1-GA.deb
sudo dpkg -i rundeck-2.6.2-1-GA.deb
#mv framework.properties framework.properties.bkp
#mv rundeck-config.properties rundeck-config.properties.bkp
#wget _______  && wget _____
service rundeckd start
echo "Rundeck Installation completed..."