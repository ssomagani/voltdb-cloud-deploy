provider "aws" {
  access_key				= "${var.access_key}"
  secret_key				= "${var.secret_key}"
  region     				= "${var.region}"
}

resource "aws_instance" mysql-sym-volt {
  count						= 1
  ami						= "${var.ami}"
  availability_zone 		= "${var.zone}"
  instance_type 			= "${var.instance_type}"
  key_name					= "${var.key_name}"

// -------------------------------------------
// Copy VoltDB Files

  provisioner "file" {
    source      = "../../../scripts/ubuntu-volt-dependencies.sh",
    destination = "/tmp/ubuntu-volt-dependencies.sh",
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
    provisioner "file" {
    source      = "${var.voltdb_distrib_tar}",
    destination = "/tmp/voltdb.tar.gz",
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }

// -------------------------------------------
// Copy MySQL files
  
  provisioner "file" {
    source      = "../../../scripts/ubuntu-mysql-install.sh",
    destination = "/tmp/ubuntu-mysql-install.sh",
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }

// -------------------------------------------  
// Copy SymmetricDS files

    provisioner "file" {
    source      = "../../../scripts/ubuntu-symmetricds-install.sh",
    destination = "/tmp/ubuntu-symmetricds-install.sh",
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
  
	provisioner "file" {
	source = "${var.symmetric_distrib_tar}",
	destination = "/tmp/symmetric-server-3.10.0.zip",
	connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
	}
	
	
  
// -------------------------------------------
// Install VoltDB
  
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/ubuntu-volt-dependencies.sh",
      "sudo /tmp/ubuntu-volt-dependencies.sh"
    ]
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
  
  provisioner "remote-exec" {
    inline = [
      "cd /tmp",
      "sudo tar -xzf /tmp/voltdb.tar.gz",
      "sudo mv /tmp/voltdb-ent-* /opt/voltdb",
      "echo 'export PATH=$PATH:/opt/voltdb/bin' >> /home/ubuntu/.profile",
      "voltdb init -f",
      "voltdb start -B"
    ]
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
  
  

// -------------------------------------------
// Install MySQL

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/ubuntu-mysql-install.sh",
      "sudo /tmp/ubuntu-mysql-install.sh"
    ]
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }

// -------------------------------------------
// Install SymmetricDS
  
    provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/ubuntu-symmetricds-install.sh",
      "sudo /tmp/ubuntu-symmetricds-install.sh"
    ]
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo cat /etc/mysql/debian.cnf"
    ]
    connection {
      type     			= "ssh"
      user			= "${var.ssh_user}"
      private_key		= "${file(var.key_path)}"
   }
  }
  
}
