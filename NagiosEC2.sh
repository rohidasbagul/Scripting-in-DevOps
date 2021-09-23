#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

sudo yum install httpd php php-cli gcc glibc glibc-common gd gd-devel net-snmp -y
sudo service httpd start  #service start [rohidasbagul@e-zest.in]
sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagcmd apache
cd /opt/
sudo wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.1.1.tar.gz
sleep 2
sudo tar xzf nagios-4.1.1.tar.gz
cd nagios-4.1.1
./configure --with-command-group=nagcmd
sudo make all
sudo make install
sudo make install-init
sudo make install-config
sudo make install-commandmode
sudo make install-webconf
#sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin  #passwd
sudo htpasswd -c -b /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin
sudo service httpd restart
cd /opt
sudo wget http://nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz
sleep 2
sudo tar xzf nagios-plugins-2.1.1.tar.gz
cd nagios-plugins-2.1.1
./configure --with-nagios-user=nagios --with-nagios-group=nagios
sudo make
sudo make install
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
sudo service nagios start
sudo chkconfig --add nagios
sudo chkconfig nagios on
echo "Nagios Server & plugins installation completed...!"