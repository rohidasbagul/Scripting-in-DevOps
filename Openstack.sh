#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

#confiure Host file
apt -y install software-properties-common
add-apt-repository cloud-archive:newton
apt -y update && apt -y dist-upgrade
apt -y install python-openstackclient
apt-get -y install openssh-server
echo " Installation start..."
apt -y install python-openstackclient
apt -y install mariadb-server python-pymysql
apt -y install rabbitmq-server
apt -y install memcached python-memcache
apt -y install keystone
apt -y install glance
apt -y install nova-api nova-conductor nova-consoleauth nova-novncproxy nova-scheduler
apt -y install neutron-server neutron-plugin-ml2 neutron-linuxbridge-agent neutron-l3-agent neutron-dhcp-agent neutron-metadata-agent
apt -y install neutron-linuxbridge-agent
apt -y install openstack-dashboard
echo "Installation complated...!"