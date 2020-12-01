# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "null_resource" "fss_info_transfer" {

  triggers = {
    instance_id = var.oci_admin.admin_id
  }

  connection {
    host = local.admin_ip
    private_key = var.oci_identity.opc_ssh_private_key
    timeout = "5m"
    type = "ssh"
    user = "opc"

    bastion_user        = "opc"
    bastion_private_key = var.oci_identity.opc_ssh_private_key
    bastion_host        = var.bastion_ip
  }

  provisioner "file" {
    content      = data.template_file.fss_inputs.rendered
    destination = "/tmp/fss.yaml"
  }
}


resource "local_file" "fss_info_transfer" {
  ###depends_on = [ oci_core_instance.test_instance, null_resource.update_server ]

  content         = data.template_file.fss_inputs.rendered
  file_permission = "700"
  filename        = "fss.yaml"
}