data "template_file" "deployment" {
  template = "${file("${path.module}/deployment.tpl")}"
  vars = {
    kfactor = "${var.kfactor}"
    sitesperhost = "${var.sitesperhost}"
    dr_id = "${var.dr_id}"
    source_str = "${var.host_string_source}"
  }
}

resource "null_resource" "export_rendered_template" {
  provisioner "local-exec" {
    command = "echo ${join("", data.template_file.deployment.*.rendered)} > deployment-${var.dr_id}.xml"
  }
}

resource "aws_instance" volt {
  count				= "${var.node_count}"
  ami				= "${var.ami}"
  availability_zone 		= "${var.zone}"
  instance_type 		= "${var.instance_type}"
  key_name			= "${var.key_name}"
  private_ip 			= "${cidrhost(var.subnet_cidr_block, count.index + var.ip_start_offset)}"
  subnet_id			= "${var.subnet_id}"
  vpc_security_group_ids 	= ["${var.security_group_id}"]

  provisioner "file" {
	source			= "deployment-${var.dr_id}.xml",
	destination 		= "/home/ubuntu/deployment.xml"
	connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
    }
  }
  
  provisioner "file" {
    source      		= "../../scripts/start-volt-cluster.sh"
    destination 		= "/home/ubuntu/start-volt-cluster.sh"
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
}

resource "null_resource" "copy_license" {
	count			= "${var.license_path == "" ? 0 : var.node_count}"
	provisioner "file" {
	source			= "${var.license_path}",
	destination 		= "/opt/voltdb/voltdb/license.xml"
	connection {
	  host     		= "${element(aws_instance.volt.*.public_ip, count.index)}"
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
    }
  }
  depends_on			= ["aws_instance.volt"]
}

resource "null_resource" "start-volt-cluster" {
  count				= "${var.node_count}"
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/start-volt-cluster.sh",
      "/home/ubuntu/start-volt-cluster.sh ${var.node_count} ${var.host_string_self} > startup.log",
    ]
    connection {
	  host     		= "${element(aws_instance.volt.*.public_ip, count.index)}"
      type     			= "ssh"
      user    			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
	depends_on		= ["null_resource.copy_license"]
}
