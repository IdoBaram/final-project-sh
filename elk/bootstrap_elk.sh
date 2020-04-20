#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

ELK_VERSION="7.6.0"

# update apt
apt-get update --quiet
apt-get install -y unzip ifupdown git apt-transport-https default-jre --quiet
echo "done apt"
java -version
[ -z $JAVA_HOME ] && echo "JAVA_HOME not set" || echo "JAVA_HOME is ${JAVA_HOME}"
echo "done java"
sleep 10

# install the Elastic PGP Key and repo
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list
echo "done Elastic PGP Key and repo"
sleep 10

apt-get install --quiet -y elasticsearch=$ELK_VERSION 
echo "done elk"
sleep 10

# copy over configs
mkdir /etc/elasticsearch/
cp /home/ubuntu/elk/elk/configs/elasticsearch/elasticsearch.yml /etc/elasticsearch/
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service
/bin/systemctl start elasticsearch.service
echo "done copy over configs"
sleep 10

# Install Kibana
apt-get install --quiet -y kibana=$ELK_VERSION 
echo "done Install Kibana"
sleep 10

# copy over configs
cp /home/ubuntu/elk/elk/configs/kibana/kibana.yml /etc/kibana/
echo "done copy over configs"
sleep 10

/bin/systemctl daemon-reload
/bin/systemctl enable kibana.service
systemctl start kibana.service
echo "done copy over configs"
sleep 10

# install Logstash
apt-get install  --quiet -y logstash=1:$ELK_VERSION-1 
apt-get install --quiet -y filebeat
## copy over configs
#cp -R /home/ubuntu/elk/elk/configs/logstash/* /etc/logstash/conf.d/
#systemctl enable logstash.service
#systemctl start logstash.service
echo "done install Logstash"

# Smoke tests
netstat -pant
curl -XGET -s http://localhost:9200


