#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

yum update -y
#write ip addr & hostname in /etc/hosts file
#sed -i '2s/a*/ 10.0.1.242	puppet /' /etc/hosts #write puppetmaster IP addr & Hostname here 
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sleep 2
yum update -y
yum install puppet -y
sed -i '26s/a*/ server = puppet /' /etc/puppet/puppet.conf  	#hostname set 
sed -i '27s/a*/  pluginsync = true /' /etc/puppet/puppet.conf 
sleep 2
/etc/init.d/puppet start
echo "Installation Successfully..."
