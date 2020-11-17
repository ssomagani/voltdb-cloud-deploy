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

sudo wget -qO - http://packages.confluent.io/deb/5.1/archive.key | sudo apt-key add -
sudo add-apt-repository 'deb [arch=amd64] http://packages.confluent.io/deb/5.1 stable main'
sudo apt-get update && sudo apt-get -y install confluent-community-2.11
