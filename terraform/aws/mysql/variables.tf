variable access_key 			{ }
variable secret_key			{ }
variable public_key 			{ }
variable ami 				{ default 	= "ami-0a313d6098716f372" }
variable region				{ default 	= "us-east-1" }
variable zone 				{ default 	= "us-east-1b" }
variable instance_type 			{ default 	= "t2.small" }
variable key_name			{ default 	= "ec2" }
variable vpc_cidr_block 		{ default	= "192.168.1.0/24" }
variable subnet_cidr_block		{ default 	= "192.168.1.0/28" }
variable ip_start_offset		{ default 	= 5 }
variable node_count			{ default 	= 1 }
variable key_path			{ default = "/Users/seetasomagani/.ssh/ec2" }
variable ssh_user			{ default = "ubuntu" }