#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
sudo yum update -y
sudo yum install puppet -y

#vim /etc/puppetlabs/puppet/puppet.conf  
#[agent]
#server = ip-172-0-101-235.ec2.internal  <-- Server DNS
#runinterval = 600  

cp /opt/puppetlabs/bin/puppet /usr/sbin/
/etc/init.d/puppet restart
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
#sudo puppet agent --test   Cert generate...
echo "Puppet agent install successfully..."