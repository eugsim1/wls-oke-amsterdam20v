# Copyright  2019, 2020 Oracle Corporation and/or affiliates.  All rights reserved.

resource "null_resource" "provisioner" {

  depends_on = [null_resource.dev_mode_provisioning, null_resource.cluster_info_transfer, null_resource.fss_info_transfer]

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

  provisioner "remote-exec" {
    inline = [
      # In dev mode, both provStartMarker and devModeMarker will need to be available on VM
      # before the provisioning will start.
      "sudo touch /u01/.markers/provStartMarker"
    ]
  }
}