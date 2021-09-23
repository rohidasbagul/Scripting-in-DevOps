#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

echo "Installation Nagios start..."
sudo apt-get -y update 
sudo apt-get -y install wget build-essential apache2 php5 php5-gd libgd2-xpm-dev libapache2-mod-php5 apache2-utils 
cd /opt
sudo wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.4.tar.gz
sudo wget http://nagios-plugins.org/download/nagios-plugins-2.0.tar.gz
sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagios www-data
sudo usermod -G nagcmd www-data
tar zxvf nagios-4.0.4.tar.gz
tar zxvf nagios-plugins-2.0.tar.gz 
cd nagios-4.0.4/
./configure --with-nagios-group=nagios --with-command-group=nagcmd --with-mail=/usr/bin/sendmail
sudo make all
sudo make install
sudo make install-init
sudo make install-config
sudo make install-commandmode
/usr/bin/install -c -m 644 sample-config/httpd.conf /etc/apache2/sites-enabled/nagios.conf
sudo cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/
sudo chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers
htpasswd -c -b /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
/etc/init.d/nagios start
/etc/init.d/nagios status
cd /opt/nagios-plugins-2.0
./configure --with-nagios-user=nagios --with-nagios-group=nagios
sudo make
sudo make install
sudo a2enmod cgi
sudo service apache2 restart
echo "=============================Add Nagios Host================================="
cd /opt && wget http://liquidtelecom.dl.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz
tar xzf nrpe-2.15.tar.gz
cd nrpe-2.15
sudo apt-get -y install libssl-dev 
./configure --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu
sudo make all
sudo make install
sudo make install-daemon
#echo "cfg_dir=/usr/local/nagios/etc/servers" >> /usr/local/nagios/etc/nagios.cfg
#/usr/local/nagios/libexec/check_nrpe -H <hostname>
sudo chown nagios:nagcmd /usr/local/nagios/var/rw
sudo chown nagios:nagcmd /usr/local/nagios/var/rw/nagios.cmd
/etc/init.d/nagios restart
sudo service apache2 restart
echo "Installation successfuly completed..."

#Add This into bellow File.
#/usr/local/nagios/etc/objects/commands.cfg

#define command{
#       command_name    check_nrpe
#        command_line    $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
#}