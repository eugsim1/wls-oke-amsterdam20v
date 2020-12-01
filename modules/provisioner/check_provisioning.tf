# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

#Runnning series of status check each to ensure that ssh connection
#failure does not affect the status check
#check_provisioning_status.py runs for 60 mins each time
resource "null_resource" "check_provisioning_status_1" {
  depends_on = [null_resource.provisioner]

  triggers = {
    instance_id = var.oci_admin.admin_id
  }

  connection {
    host        = local.admin_ip
    private_key = var.oci_identity.opc_ssh_private_key
    #timeout for getting ssh connection
    timeout     = "10m"
    type        = "ssh"
    user        = "opc"

    bastion_user        = "opc"
    bastion_private_key = var.oci_identity.opc_ssh_private_key
    bastion_host        = var.bastion_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /u01/scripts/status/check_provisioning_status.py",
      "sudo python /u01/scripts/status/check_provisioning_status.py"
    ]
  }
}

resource "null_resource" "check_provisioning_status_2" {
  depends_on = [
    null_resource.check_provisioning_status_1]

  triggers = {
    instance_id = var.oci_admin.admin_id
  }

  connection {
    host = local.admin_ip
    private_key = var.oci_identity.opc_ssh_private_key
    #timeout for getting ssh connection
    timeout     = "10m"
    type = "ssh"
    user = "opc"

    bastion_user = "opc"
    bastion_private_key = var.oci_identity.opc_ssh_private_key
    bastion_host = var.bastion_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /u01/scripts/status/check_provisioning_status.py",
      "sudo python /u01/scripts/status/check_provisioning_status.py"
    ]
  }
}

resource "null_resource" "check_provisioning_status_3" {
  depends_on =[
    null_resource.check_provisioning_status_2]

  triggers = {
    instance_id = var.oci_admin.admin_id
  }

  connection {
    host = local.admin_ip
    private_key = var.oci_identity.opc_ssh_private_key
    #timeout for getting ssh connection
    timeout     = "10m"
    type = "ssh"
    user = "opc"

    bastion_user = "opc"
    bastion_private_key = var.oci_identity.opc_ssh_private_key
    bastion_host = var.bastion_ip
  }

  // final status check and clean up
  provisioner "remote-exec" {
    inline = [
      "sudo python /u01/scripts/status/check_provisioning_status.py True",
      "[ -f '/u01/.lb_urls' ] && cat /u01/.lb_urls",
      "sudo cp /home/opc/.ssh/authorized_keys.bak /home/opc/.ssh/authorized_keys",
      "rm -f /home/opc/.ssh/id_rsa",
      "rm -f /home/opc/.ssh/authorized_keys.bak",
      "chown -R opc:opc /home/opc/.ssh/authorized_keys"
    ]
  }
}

resource "null_resource" "clean_up" {
  depends_on = [null_resource.check_provisioning_status_3]
  // delete opc keys from bastion host
  provisioner "remote-exec" {
    connection {
      agent = false
      #timeout for getting ssh connection
      timeout     = "10m"
      host = var.bastion_ip
      user = "opc"
      private_key = var.oci_identity.opc_ssh_private_key
    }

    inline = [
      "sudo cp /home/opc/.ssh/authorized_keys.bak /home/opc/.ssh/authorized_keys",
      "rm -f /home/opc/.ssh/authorized_keys.bak",
      "chown -R opc:opc /home/opc/.ssh/authorized_keys"
    ]
  }
}