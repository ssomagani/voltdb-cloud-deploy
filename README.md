# voltdb-cloud-deploy

Scripts to deploy VoltDB on public cloud environments

### 1. Build a new VoltDB AMI based on Ubuntu 18.04
Make sure that you have the correct VoltDB distributable available 
First ensure that your shared AWS credentials file is available on your machine at the default location ~/.aws/credentials

	cd voltdb-cloud-deploy/packer/aws
	packer build -var-file aws-variables.json aws-voltdb.json 

### 2. Run a VoltDB cluster based on an AMI 
Ensure that you have an ssh key to use and create a secret.tfvars file that contains the three key value pairs where the access_key and secret_key are your AWS keys and the public_key is from the ssh key:

	access_key = 
	secret_key = 
	public_key = 

Then initialize and run terraform template to create by default a 3 node cluster with k-factor=1

	cd voltdb-cloud-deploy/terraform/aws
	terraform init
	terraform apply -var-file=/path/to/secret.tfvars
