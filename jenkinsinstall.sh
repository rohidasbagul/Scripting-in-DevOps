#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

echo "Installation jenkins start..."
sudo apt-get -y install openjdk-7-jdk  # As per requirement
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get -y update
sudo apt-get -y install jenkins 
service jenkins start
echo "Jenkins install complate...!"