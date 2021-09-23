#!/bin/bash
#USE_ME
#All requied download
#ROHIDAS_BAGUL
 
# install pwgen for password-generation
yum upgrade ca-certificates --enablerepo=epel
yum --enablerepo=epel -y install pwgen
 
# mongodb
cat >/etc/yum.repos.d/mongodb-org.repo <<'EOT'
[mongodb-org]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1
EOT
 
yum -y install mongodb-org
chkconfig mongod on
service mongod start
 
# elasticsearch
rpm --import https://packages.elasticsearch.org/GPG-KEY-elasticsearch
 
cat >/etc/yum.repos.d/elasticsearch.repo <<'EOT'
[elasticsearch-1.4]
name=Elasticsearch repository for 1.4.x packages
baseurl=http://packages.elasticsearch.org/elasticsearch/1.4/centos
gpgcheck=1
gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch
enabled=1
EOT
 
yum -y install elasticsearch
chkconfig --add elasticsearch
 
# configure elasticsearch 
sed -i -- 's/#cluster.name: elasticsearch/cluster.name: graylog2/g' /etc/elasticsearch/elasticsearch.yml 
sed -i -- 's/#network.bind_host: localhost/network.bind_host: localhost/g' /etc/elasticsearch/elasticsearch.yml
 
service elasticsearch stop
service elasticsearch start
 
# java
yum -y update
yum -y install java-1.7.0-openjdk
update-alternatives --set java /usr/lib/jvm/jre-1.7.0-openjdk.x86_64/bin/java
 
# graylog
wget https://packages.graylog2.org/releases/graylog2-server/graylog-1.0.1.tgz
tar xvzf graylog-1.0.1.tgz -C /opt/
mv /opt/graylog-1.0.1/ /opt/graylog/
cp /opt/graylog/bin/graylogctl /etc/init.d/graylog
sed -i -e 's/GRAYLOG2_SERVER_JAR=\${GRAYLOG2_SERVER_JAR:=graylog.jar}/GRAYLOG2_SERVER_JAR=\${GRAYLOG2_SERVER_JAR:=\/opt\/graylog\/graylog.jar}/' /etc/init.d/graylog
sed -i -e 's/LOG_FILE=\${LOG_FILE:=log\/graylog-server.log}/LOG_FILE=\${LOG_FILE:=\/var\/log\/graylog-server.log}/' /etc/init.d/graylog
 
cat >/etc/init.d/graylog <<'EOT'
#!/bin/bash
# chkconfig: 345 90 60
# description: graylog control
sh /opt/graylog/bin/graylogctl $1
EOT
 
chkconfig --add graylog
chkconfig graylog on
chmod +x /etc/init.d/graylog
 
# graylog web
wget https://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-1.0.1.tgz
tar xvzf graylog-web-interface-1.0.1.tgz -C /opt/
mv /opt/graylog-web-interface-1.0.1/ /opt/graylog-web/
 
cat >/etc/init.d/graylog-web <<'EOT'
#!/bin/bash
# chkconfig: 345 91 61
# description: graylog web interface
sh /opt/graylog-web/bin/graylog-web-interface > /dev/null 2>&1 &
EOT
 
chkconfig --add graylog-web
chkconfig graylog-web on
chmod +x /etc/init.d/graylog-web
 
#configure 
mkdir --parents /etc/graylog/server/
cp /opt/graylog/graylog.conf.example /etc/graylog/server/server.conf
sed -i -e 's/password_secret =.*/password_secret = '$(pwgen -s 96 1)'/' /etc/graylog/server/server.conf
 
sed -i -e 's/root_password_sha2 =.*/root_password_sha2 = '$(echo -n password | shasum -a 256 | awk '{print $1}')'/' /etc/graylog/server/server.conf
 
sed -i -e 's/application.secret=""/application.secret="'$(pwgen -s 96 1)'"/g' /opt/graylog-web/conf/graylog-web-interface.conf
sed -i -e 's/graylog2-server.uris=""/graylog2-server.uris="http:\/\/127.0.0.1:12900\/"/g' /opt/graylog-web/conf/graylog-web-interface.conf
 
service graylog start
sleep 30
service graylog-web start