# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

data "template_file" "key_script" {
  template = file("${path.module}/templates/opc_keys.tpl")

  vars = {
    opc_ssh_private_key   = var.oci_identity.opc_ssh_private_key
    opc_ssh_pubKey        = var.oci_identity.opc_ssh_public_key
  }
}


# cloud init for admin
data "template_cloudinit_config" "admin" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "ainit.sh"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.key_script.rendered}"
  }
  part {
    filename     = "init.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/cloudinit/bootstrap.tpl")
  }
}