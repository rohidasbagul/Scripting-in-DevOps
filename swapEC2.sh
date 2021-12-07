#!/bin/bash
#USE_ME
#ROHIDAS_BAGUL

dd if=/dev/zero of=/swap bs=1024 count=2097152 #create 2GB
sleep 2
mkswap /swap && chown root. /swap && chmod 0600 /swap && swapon /swap
echo /swap swap swap defaults 0 0 >> /etc/fstab
echo vm.swappiness = 60 >> /etc/sysctl.conf && sysctl -p
#EC2-swap space create.
echo "swap sapce create completed..."
