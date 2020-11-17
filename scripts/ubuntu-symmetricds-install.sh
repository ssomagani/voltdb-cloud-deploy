sudo apt-get install dirmngr --install-recommends -y
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo add-apt-repository -y ppa:webupd8team/java

sudo apt-get update

sudo apt-get install openjdk-8-jre-headless -y
sudo apt-get install openjdk-8-jdk-headless -y

sudo apt-get install unzip
	
unzip /tmp/symmetric-server-3.10.0.zip /opt/symmetric/
find /opt/lampp/htdocs -type d -exec chmod 755 {} \;
find /opt/lampp/htdocs -type f -exec chmod 666 {} \;