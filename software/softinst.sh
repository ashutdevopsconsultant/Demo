#!/bin/sh
---- install Oracle JDK 1.8
$ wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.rpm
$sudo yum install -y jdk-8u141-linux-x64.rpm

---- install OpenJDK
$ vi install.sh
yum install -y java-1.8.0-openjdk-devel
yum remove java-1.7.0-openjdk
wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
yum install -y apache-maven
mvn --version

yum install -y git 

$ chmod 755 install.sh
$ sudo ./install.sh


---- python
sudo pip install gunicorn
sudo pip install -r requirements.txt

Amazon Linux AMI 2014.09.2

Elasticsearch 1.4.4
===============

Commands
---------------
sudo su
yum update -y
cd /root
wget https://download.elasticsearch.org/el...
yum install elasticsearch-1.4.4.noarch.rpm -y
rm -f elasticsearch-1.4.4.noarch.rpm
cd /usr/share/elasticsearch/
./bin/plugin -install mobz/elasticsearch-head
./bin/plugin -install lukas-vlcek/bigdesk
./bin/plugin install elasticsearch/elasticsearch-cloud-aws/2.4.1
cd /etc/elasticsearch
nano elasticsearch.yml

Config
---------
cluster.name: awstutorialseries
cloud.aws.access_key: ACCESS_KEY_HERE
cloud.aws.secret_key: SECRET_KEY_HERE
cloud.aws.region: us-east-1
discovery.type: ec2
discovery.ec2.tag.Name: "AWS Tutorial Series - Elasticsearch"
http.cors.enabled: true
http.cors.allow-origin: "*"

Commands
---------------
service elasticsearch start 


Logstash 1.4.2
===========

Commands
---------------
sudo su
yum update -y
cd /root
wget https://download.elasticsearch.org/lo...
yum install logstash-1.4.2-1_2c0f5a1.noarch.rpm -y
rm -f logstash-1.4.2-1_2c0f5a1.noarch.rpm
nano /etc/logstash/conf.d/logstash.conf

Config (XXX is a greater than symbol youtube does not allow that in the comments)
--------------------------------------------------------------------------------------------------------------
input { file { path =XXX "/tmp/logstash.txt" } } output { elasticsearch { host =XXX "ELASTICSEARCH_URL_HERE" protocol =XXX "http" } }

Commands
---------------
service logstash start


Kibana 4.0.1
============

Commands
---------------
sudo su
yum update -y
cd /root
wget https://download.elasticsearch.org/ki...
tar xzf kibana-4.0.1-linux-x64.tar.gz
rm -f kibana-4.0.1-linux-x64.tar.gz
cd kibana-4.0.1-linux-x64
nano config/kibana.yml 

Config
--------
elasticsearch_url: "ELASTICSEARCH_URL_HERE"

Commands
---------------
nohup ./bin/kibana &

Navigate In Browser
---------------------------
http://KIBANA_URL:5601/
