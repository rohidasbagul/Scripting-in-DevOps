#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL

service chrony restart
service mysql restart
service memcached restart
service apache2 restart
service glance-registry restart
service glance-api restart
service nova-api restart
service nova-consoleauth restart
service nova-scheduler restart
service nova-conductor restart
service nova-novncproxy restart
service nova-compute restart
service nova-api restart
service neutron-server restart
service neutron-linuxbridge-agent restart
service neutron-dhcp-agent restart
service neutron-metadata-agent restart
service neutron-l3-agent restart
echo "All service started...!"
