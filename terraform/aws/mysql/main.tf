provider "aws" {
  access_key				= "${var.access_key}"
  secret_key				= "${var.secret_key}"
  region     				= "${var.region}"
}

resource "aws_key_pair" "mysql-key" {
  key_name   				= "${var.key_name}"
  public_key 				= "${var.public_key}"
}

resource "aws_instance" mysql {
  count						= "${var.node_count}"
  ami						= "${var.ami}"
  availability_zone 		= "${var.zone}"
  instance_type 			= "${var.instance_type}"
  key_name					= "${var.key_name}"
  
  provisioner "file" {
    source      = "../../../scripts/ubuntu-mysql-install.sh",
    destination = "/tmp/ubuntu-mysql-install.sh",
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
  
    provisioner "file" {
    source      = "../../../scripts/ubuntu-symmetricds-install.sh",
    destination = "/tmp/ubuntu-symmetricds-install.sh",
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/ubuntu-mysql-install.sh",
      "sudo /tmp/ubuntu-mysql-install.sh",
    ]
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
  
    provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/ubuntu-symmetricds-install.sh",
      "sudo /tmp/ubuntu-symmetricds-install.sh",
    ]
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
}
