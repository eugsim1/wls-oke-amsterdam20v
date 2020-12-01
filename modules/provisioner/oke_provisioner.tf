# Copyright  2019, 2020 Oracle Corporation and/or affiliates.  All rights reserved.

resource "null_resource" "cluster_info_transfer" {

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
      "mkdir -p $HOME/.kube",
      #TODO: check if this should be done for customer
      "echo 'export KUBECONFIG=/home/opc/.kube/config' >> ~/.bashrc",
      "echo 'export OCI_CLI_AUTH=instance_principal' >>  ~/.bashrc",

      #Create cluster info
      "sudo su - opc -c 'echo ${jsonencode(format(" { \"compartment_id\":\"%s\", \"cluster_id\":\"%s\", \"admin_instance_id\":\"%s\", \"region\":\"%s\"}",
        var.oci_identity.compartment_id,
        var.oke_cluster_id,
        var.oci_admin.admin_id,
        var.oci_identity.region
      ))} > ${"/tmp/.oke_cluster_info"}'",
    ]
  }

  provisioner "file" {
    content     = data.oci_containerengine_cluster_kube_config.kube_config.content
    destination = "~/.kube/config"
  }
}


resource "null_resource" "bastion_info_transfer" {

  triggers = {
    instance_id = var.oci_admin.admin_id
  }

  connection {
    host = var.bastion_ip
    private_key = var.oci_identity.opc_ssh_private_key
    timeout = "5m"
    type = "ssh"
    user = "opc"


  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p $HOME/.kube",
      #TODO: check if this should be done for customer
      "echo 'export KUBECONFIG=/home/opc/.kube/config' >> ~/.bashrc",
      "echo 'export OCI_CLI_AUTH=instance_principal' >>  ~/.bashrc",

      #Create cluster info
      "sudo su - opc -c 'echo ${jsonencode(format(" { \"compartment_id\":\"%s\", \"cluster_id\":\"%s\", \"admin_instance_id\":\"%s\", \"region\":\"%s\"}",
        var.oci_identity.compartment_id,
        var.oke_cluster_id,
        var.oci_admin.admin_id,
        var.oci_identity.region
      ))} > ${"/tmp/.oke_cluster_info"}'",
    ]
  }

  provisioner "file" {
    content     = data.oci_containerengine_cluster_kube_config.kube_config.content
    destination = "~/.kube/config"
  }
}



resource "local_file" "cluster_info_transfer" {
  ###depends_on = [ oci_core_instance.test_instance, null_resource.update_server ]

  content         = data.oci_containerengine_cluster_kube_config.kube_config.content
  file_permission = "700"
  filename        = "kube-config.txt"
}








