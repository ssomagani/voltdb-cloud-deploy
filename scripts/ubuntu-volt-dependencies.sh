#! /bin/bash

apt-get install dirmngr --install-recommends -y
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo add-apt-repository -y ppa:webupd8team/java

apt-get update

apt-get install ntp -y
apt-get install openjdk-8-jre-headless -y
apt-get install openjdk-8-jdk-headless -y
apt-get install python -y

sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"
