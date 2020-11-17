#! /bin/bash

sudo apt-get update
sudo apt-get install docker.io
wget https://downloads.cloudera.com/demo_vm/docker/cloudera-quickstart-vm-5.13.0-0-beta-docker.tar.gz

tar -xzf cloudera-quickstart-vm-5.13.0-0-beta-docker.tar.gz
docker import cloudera-quickstart-vm-5.13.0-0-beta-docker/cloudera-quickstart-vm-5.13.0-0-beta-docker.tar

docker images

docker run --hostname=quickstart.cloudera --privileged=true -t -i --publish-all=true -p 8888:8888 -p 8080:8080 -p 7180:7180 [IMAGE_NAME] /usr/bin/docker-quickstartdocker run --hostname=quickstart.cloudera --privileged=true -t -i --publish-all=true -p 8888:8888 -p 8080:8080 -p 7180:7180 fabf06e98441 /usr/bin/docker-quickstart

/home/clouder/cloudera-manager