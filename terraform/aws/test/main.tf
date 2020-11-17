
data "template_file" "deployment" {
  template = "${file("${path.module}/deployment.tpl")}"
  vars = {
    kfactor = 1
    sitesperhost = 3
    dr_id = 2
    source_str = "asdf"
  }
}

resource "null_resource" "export_rendered_template" {
  provisioner "local-exec" {
    command = "echo ${join("", data.template_file.deployment.*.rendered)} > deployment.xml"
  }
}
