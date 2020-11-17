variable access_key 			{ }
variable secret_key			{ }
variable public_key 			{ }
variable ami 				{ default 	= "ami-0a313d6098716f372" }
variable region				{ default 	= "us-east-1" }
variable zone 				{ default 	= "us-east-1b" }
variable instance_type 			{ default 	= "t2.medium" }
variable key_name			{ default 	= "ec2" }
variable ip_start_offset		{ default 	= 5 }
variable node_count			{ default 	= 1 }
variable key_path			{ default = "/Users/seetasomagani/.ssh/ec2" }
variable ssh_user			{ default = "ubuntu" }
variable voltdb_distrib_tar { default = "/Users/seetasomagani/Projects/voltdb-cloud-deploy/distributions/voltdb-ent-8.4.tar.gz" }
variable symmetric_distrib_tar { default = "/Users/seetasomagani/Projects/symmetric-ds/symmetric-server/build/distributions/symmetric-server-3.10.0.zip" }