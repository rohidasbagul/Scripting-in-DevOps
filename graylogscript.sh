#!/bin/bash
#USE_ME
#All requied download
#API http://graylog_public_IP:9000/
#ROHIDAS_BAGUL

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update -y 
sudo apt-get install mongodb-org -y 
sleep 2
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-1.7.x.list
sudo apt-get update -y
sudo apt-get install elasticsearch -y
sleep 2
sudo mv /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elelasticsearch.yml.bkp
cd /etc/elasticsearch/ && wget https://s3.amazonaws.com/puppet-data/elasticsearch.yml
#sudo cp /tmp/graylog/elasticsearch/elasticsearch.yml  /etc/elasticsearch/
sleep 2
sudo service elasticsearch restart
sudo update-rc.d elasticsearch defaults 95 10
curl -XGET 'http://localhost:9200/_cluster/health?pretty=true'
cd /opt && wget https://packages.graylog2.org/repo/packages/graylog-1.3-repository-ubuntu14.04_latest.deb
sudo dpkg -i graylog-1.3-repository-ubuntu14.04_latest.deb
sudo apt-get update -y
sudo apt-get install apt-transport-https -y
sudo apt-get install graylog-server -y
sudo apt-get install pwgen -y
SECRET=$(pwgen -s 96 1)
sudo -E sed -i -e 's/password_secret =.*/password_secret = '$SECRET'/' /etc/graylog/server/server.conf
PASSWORD=$(echo -n password | shasum -a 256 | awk '{print $1}')
sudo -E sed -i -e 's/root_password_sha2 =.*/root_password_sha2 = '$PASSWORD'/' /etc/graylog/server/server.conf
sudo mv /etc/graylog/server/server.conf /etc/graylog/server/server.conf.bkp
cd /etc/graylog/server/ && wget https://s3.amazonaws.com/puppet-data/server.conf
#sudo cp /tmp/graylog/server/server.conf /etc/graylog/server/
sudo service graylog-server start
sleep 2
sudo apt-get install graylog-web -y
SECRET=$(pwgen -s 96 1)
sudo -E sed -i -e 's/application\.secret=""/application\.secret="'$SECRET'"/' /etc/graylog/web/web.conf
sudo mv /etc/graylog/web/web.conf /etc/graylog/web/web.conf.bkp
cd /etc/graylog/web/ && wget https://s3.amazonaws.com/puppet-data/web.conf
#sudo cp /tmp/graylog/web/web.conf /etc/graylog/web/
sudo service graylog-web start
sleep 2
cd /etc/rsyslog.d/ && wget https://s3.amazonaws.com/puppet-data/rsysloc-graylog.conf
#sudo cp /tmp/graylog/rsyslog/local-graylog.conf /etc/rsyslog.d/
sudo service rsyslog restart
echo "Successfully Done..."


