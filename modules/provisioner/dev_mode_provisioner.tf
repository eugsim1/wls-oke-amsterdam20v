# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "null_resource" "dev_mode_provisioning" {
  count = var.oci_admin.mode=="DEV" ?1:0

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
    source     = "${path.module}/../../../infra/target/wlsoke-vmscripts.zip"
    destination = "/tmp/wlsoke-vmscripts.zip"
  }

  provisioner "file" {
    source     = "${path.module}/../../../infra/target/wlsoke-sharedscripts.zip"
    destination = "/u01/zips/wlsoke-sharedscripts.zip"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo unzip /tmp/wlsoke-vmscripts.zip -d /",
      "sudo chown -R opc:opc /u01",
      "sudo chmod -R +x /u01/scripts",

      # In dev mode, both provStartMarker and devModeMarker will need to be available on VM
      # before the provisioning will start.
      "sudo touch /u01/.markers/devModeMarker"
    ]
  }
}