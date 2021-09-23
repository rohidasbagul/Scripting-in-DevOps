#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

sudo apt-get update && sudo apt-get -y install ntp
sudo service ntp start
cd /opt && wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb 
sudo dpkg -i puppetlabs-release-trusty.deb 
sudo apt-get -y update 
sudo apt-get -y install puppetmaster-passenger
sudo apt-get -y install puppetmaster
sudo service apache2 stop
touch /etc/apt/preferences.d/00-puppet.pref
sed -i '1s/a*/ Package: puppet puppet-common puppetmaster-passenger /' /etc/apt/preferences.d/00-puppet.pref
sed -i '2s/a*/ Pin: version 3.8* /' /etc/apt/preferences.d/00-puppet.pref
sed -i '3s/a*/ Pin-Priority: 501 /' /etc/apt/preferences.d/00-puppet.pref
sudo rm -rf /var/lib/puppet/ssl
# comment on templatedir=$confdir/templates   present in main section,, it is not mendatory

sed -i '3s/a*/ certname = puppet /' /etc/puppet/puppet.conf
sed -i '4s/a*/ dns_alt_names = puppet /' /etc/puppet/puppet.conf
sed -i '5s/a*/ autosign = true /' /etc/puppet/puppet.conf  #used for agent auto sign __optional#
sudo puppet master --verbose --no-daemonize
sleep 5
sudo service apache2 start
sudo service puppetmaster restart