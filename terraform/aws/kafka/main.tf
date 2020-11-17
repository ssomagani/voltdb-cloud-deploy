resource "aws_instance" "${var.name}" {
  count				= "${var.node_count}"
  ami				= "${var.ami}"
  availability_zone 		= "${var.zone}"
  instance_type 		= "${var.instance_type}"
  key_name			= "${var.key_name}"
  private_ip 			= "${cidrhost(var.subnet_cidr_block, count.index + var.ip_start_offset)}"
  subnet_id			= "${var.subnet_id}"
  vpc_security_group_ids 	= ["${var.security_group_id}"]

//   provisioner "file" {
//     source      		= "../../scripts/start-kafka-cluster.sh"
//     destination 		= "/home/ubuntu/start-kafka-cluster.sh"
//     connection {
//       type     			= "ssh"
//       user			= "${var.ssh_user}"
//       private_key		= "${file(var.key_path)}"
//    }
//   }
}
