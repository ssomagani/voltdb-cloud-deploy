resource "google_compute_instance" volt {
  machine_type = "n1-standard-1"
  count			= "${var.nodeCount}"
  name         	= "${var.name}-${count.index}"

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }
  
  provisioner "file" {
	source			= "../../volt-configs/deployment.xml",
	destination 	= "/home/ubuntu/deployment.xml"
	connection {
      type     		= "ssh"
      user			= "ubuntu"
    }
  }
  
  provisioner "file" {
    source      = "../../volt-scripts/start-volt-hostnames.sh"
    destination = "/home/ubuntu/start-volt.sh"
    connection {
      type     		= "ssh"
      user			= "ubuntu"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/start-volt.sh",
      "/home/ubuntu/start-volt.sh ${var.nodeCount} ${var.name}",
    ]
    connection {
      type     		= "ssh"
      user    		= "ubuntu"
    }
  }
}
