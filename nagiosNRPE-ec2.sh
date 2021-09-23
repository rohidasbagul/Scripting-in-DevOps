#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo yum --enablerepo=epel -y install nrpe nagios-plugins
#vim /etc/nagios/nrpe.cfg
#allowed_hosts=127.0.0.1, 192.168.1.110
sudo service nrpe start
sudo chkconfig nrpe on
 