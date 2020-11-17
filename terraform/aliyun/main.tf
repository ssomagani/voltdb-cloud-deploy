provider "alicloud" {
  access_key				= "${var.access_key}"
  secret_key				= "${var.secret_key}"
  region     				= "${var.region}"
}

data "alicloud_instance_types" "2c4g" {
  cpu_core_count = 2
  memory_size = 4
}

resource "aws_key_pair" "volt-key" {
  key_name   				= "${var.key_name}"
  public_key 				= "${var.public_key}"
}

resource "alicloud_instance" "volt" {
	image_id			= "${var.image}"
	zone			 	= "${var.zone}"
	instance_type 			= "${data.alicloud_instance_types.2c4g.instance_types.0.id}"
	subnet_id 			= "${module.vpc.subnet_id}"
	subnet_cidr_block		= "${var.subnet_cidr_block}"
	ip_start_offset			= "${var.ip_start_offset}"
  	system_disk_category = "cloud_efficiency"
  	security_groups      = ["${alicloud_security_group.default.id}"]
}
