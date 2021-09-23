#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

yum update -y
#write ip addr & hostname in /etc/hosts file
ipaddr=$(/sbin/ifconfig eth0| grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
hn=$(hostname)
hnd=$(hostname -f)
sed -i '1s/a*/'$ipaddr'  '$hnd'   '$hn'/' /etc/hosts
echo "put IP addr and hostname in hosts file Successfully..."
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sleep 4
yum update -y
yum install puppet-server -y
puppet resource package puppet-server ensure=latest
sed -i '2s/a*/ server = '$hnd'/' /etc/puppet/puppet.conf
sed -i '3s/a*/  pluginsync = true /' /etc/puppet/puppet.conf 
sed -i '1s/a*/ [modules] /' /etc/puppet/fileserver.cong
/etc/init.d/puppetmaster start
sleep 5
/etc/init.d/puppetmaster status
netstat -tupln | grep 8140
echo "Port Running Successfully... AND Installation Successfully..."
