#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

echo "++++++++++++++++++++++++++++++++++++++++++++++
						OpenVPN-Server
	++++++++++++++++++++++++++++++++++++++++++++++"	

wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -Uvh epel-release-6-8.noarch.rpm
yum install openvpn -y
yum install easy-rsa -y --enablerepo=epel
cp /usr/share/doc/openvpn-2.3.12/sample/sample-config-files/server.conf /etc/openvpn/
#vim /etc/openvpn/server.conf			ADD DETAILS ON CONFIG
mkdir -p /etc/openvpn/easy-rsa/keys

cp /usr/share/easy-rsa/2.0/* /etc/openvpn/easy-rsa/
#vim /etc/openvpn/easy-rsa/vars		ADD CONFIG 
cd /etc/openvpn/easy-rsa/
source ./vars
./clean-all
./build-ca
./build-key-server server
./build-dh

cd /etc/openvpn/easy-rsa/keys/
cp dh2048.pem ca.crt server.crt server.key /etc/openvpn/
cd /etc/openvpn/easy-rsa
./build-key client
iptables -t nat -A POSTROUTING -s 10.0.1.0/24 -o eth0 -j MASQUERADE
service iptables save
vim /etc/sysctl.conf
sysctl -p
service openvpn start
chkconfig openvpn on
#https://www.digitalocean.com/community/tutorials/how-to-setup-and-configure-an-openvpn-server-on-centos-6
#http://www.itskarma.wtf/open-vpn-on-ec2/
#http://www.tecmint.com/setup-openvpn-server-with-linux-and-windows-clients-in-centos-rhel/