#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
sudo yum update -y
sudo yum install puppetserver -y
#vim /etc/sysconfig/puppetserver  <--JAVA-RAM Size 2g 2g
sudo service puppetserver start
sudo /opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true
cp /opt/puppetlabs/bin/puppet /usr/sbin/puppet
puppet cert list --all
#vim /etc/hosts    <--- Add puppet DNS Name
/etc/init.d/puppetserver restart
echo "puppetserver 4 install successfully..."  

  
#module installation
#puppet module install mklauber-aide --version 1.1.2
#puppet module install edestecd-clamav --version 1.0.0
#unzip user_mgmt.zip -d /etc/puppetlabs/code/environments/production/modules/