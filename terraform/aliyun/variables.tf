variable access_key 			{ }
variable secret_key			{ }
variable region				{ default 	= "us-east-1" }
variable public_key 			{ }
variable image 				{ default 	= "ami-001fb21c12bbc8cdc" }
variable zone 				{ default 	= "us-east-1b" }

variable key_name			{ default 	= "aliyun" }
variable vpc_cidr_block 		{ default	= "192.168.1.0/24" }
variable subnet_cidr_block		{ default 	= "192.168.1.0/28" }
variable ip_start_offset		{ default 	= 5 }
variable node_count			{ default 	= 3 }
