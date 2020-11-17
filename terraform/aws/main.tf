provider "aws" {
  access_key				= "${var.access_key}"
  secret_key				= "${var.secret_key}"
  region     				= "us-east-1"
}

module "vpc" {
	source				= "./vpc"
	vpc_cidr_block			= "192.168.0.0/16"
}

resource "aws_subnet" "subnet-1b" {
  vpc_id 			= "${module.vpc.vpc_id}"
  cidr_block			= "192.168.1.0/20"
  availability_zone 		= "us-east-1b"
  map_public_ip_on_launch	= "true"
  tags 				= {
    Name 			= "Main"
  }
}

resource "aws_subnet" "subnet-1c" {
  vpc_id 			= "${module.vpc.vpc_id}"
  cidr_block			= "192.168.16.0/20"
  availability_zone 		= "us-east-1c"
  map_public_ip_on_launch	= "true"
  tags 				= {
    Name 			= "Main"
  }
}

data "template_file" "ips_1" {
	count 				= "${var.node_count}"
	template			= "$${cidrhost("${"192.168.1.0/20"}", ${count.index} + ${var.ip_start_offset})}"
}

data "template_file" "ips_2" {
	count 				= "${var.node_count}"
	template			= "$${cidrhost("${"192.168.16.0/20"}", ${count.index} + ${var.ip_start_offset})}"
}

locals {
	  host_string-1 	= "${join(",", data.template_file.ips_1.*.rendered)}"
	  host_string-2 	= "${join(",", data.template_file.ips_2.*.rendered)}"
}

module "volt-1" {
	source 				= "./voltdb"
	zone			 	= "us-east-1b"
	subnet_id 			= "${aws_subnet.subnet-1b.id}"
	subnet_cidr_block		= "192.168.1.0/20"
	ip_start_offset			= "${var.ip_start_offset}"
	security_group_id 		= "${module.vpc.sg_id}"
	dr_id					= "1"
	host_string_self			= "${local.host_string-1}"
	host_string_source		= "${local.host_string-2}"
}

module "volt-2" {
	source 				= "./voltdb"
	zone			 	= "us-east-1c"
	subnet_id 			= "${aws_subnet.subnet-1c.id}"
	subnet_cidr_block		= "192.168.16.0/20"
	ip_start_offset			= "${var.ip_start_offset}"
	security_group_id 		= "${module.vpc.sg_id}"
	dr_id					= "2"
	host_string_source	= "${local.host_string-1}"
	host_string_self			= "${local.host_string-2}"
}
