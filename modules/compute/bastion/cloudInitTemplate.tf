# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

data "template_file" "key_script" {
  template = file("${path.module}/templates/opc_keys.tpl")

  vars = {
    opc_ssh_pubKey     = var.oci_identity.opc_ssh_public_key
  }
}

data "template_cloudinit_config" "bastion-config" {
  gzip          = true
  base64_encode = true

  # cloud-config configuration file.
  # /var/lib/cloud/instance/scripts/*

  part {
    filename     = "ainit.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.key_script.rendered
  }

  part {
    filename     = "init.sh"
    content_type = "text/cloud-config"
    content      = file("${path.module}/userdata/bastion-bootstrap.tpl")
  }
}
