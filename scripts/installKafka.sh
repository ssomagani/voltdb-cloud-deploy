#! /bin/bash

sudo add-apt-repository 'http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ bionic main restricted'
sudo add-apt-repository 'http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ bionic-updates main restricted'
sudo add-apt-repository 'http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ bionic universe'
sudo add-apt-repository 'http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ bionic-updates universe'
sudo add-apt-repository 'http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ bionic multiverse'
sudo add-apt-repository 'http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ bionic-updates multiverse'
sudo add-apt-repository 'http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse'
sudo add-apt-repository 'http://security.ubuntu.com/ubuntu bionic-security universe'
sudo add-apt-repository 'http://security.ubuntu.com/ubuntu bionic-security multiverse'
			
sudo apt-get update
sudo apt-get -y install puppet curl python software-properties-common unzip openjdk-8-jre-headless zookeeper

mkdir /root/Downloads
curl https://downloads.apache.org/kafka/2.6.0/kafka_2.12-2.6.0.tgz -o /root/Downloads/kafka.tgz
mkdir /opt/kafka && cd /opt/kafka
tar -xvzf /root/Downloads/kafka.tgz --strip 1

echo 'delete.topic.enable = true' >> /opt/kafka/config/server.properties