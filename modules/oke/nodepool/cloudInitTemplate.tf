# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

data "template_file" "script" {
  template = "${file("${path.module}/cloudinit/bootstrap.tpl")}"

  vars = {
    weblogic_image_tag = var.weblogic_image_tag
  }
}

data "template_cloudinit_config" "nodepool-config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.sh"
    content_type = "text/cloud-config"
    content      = data.template_file.script.rendered
  }
}
