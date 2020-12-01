# Copyright  2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

output "admin_instance_id" {
  value = module.admin.admin_id
}

output "admin_instance_private_ip" {
  value = list(module.admin.admin_private_ip)
}

output "bastion_instance_id" {
  value = module.bastion.bastion_id
}

output "bastion_instance_public_ip" {
  value = list(module.bastion.bastion_public_ip)
}

output "fss_path" {
  value = local.export_path
}


resource "local_file" "loggin_bastion_ssh" {
  ###depends_on = [ oci_core_instance.test_instance, null_resource.update_server ]

  content         = format("%s %s%s", "ssh -i wls-wdt-testkey-priv.txt ", "opc@",module.bastion.bastion_public_ip )
  file_permission = "700"
  filename        = "ssh_opc_bastion.sh"
}

## ssh -i wls-wdt-testkey-priv.txt -o ProxyCommand="ssh -i wls-wdt-testkey-priv.txt -W %h:%p opc@193.123.38.135 " opc@10.0.2.2 
resource "local_file" "loggin_admin_ssh" {
  ###depends_on = [ oci_core_instance.test_instance, null_resource.update_server ]
  content         = format("%s %s%s%s %s%s", "ssh -i wls-wdt-testkey-priv.txt -o ProxyCommand=\"ssh -i wls-wdt-testkey-priv.txt -W %h:%p ", "opc@", module.bastion.bastion_public_ip,"\" ", "opc@", module.admin.admin_private_ip)
  file_permission = "700"
  filename        = "ssh_opc_admin.sh"
}


resource "local_file" "sftp_admin_ssh" {
  ###depends_on = [ oci_core_instance.test_instance, null_resource.update_server ]
  content         = format("%s %s%s %s%s", "sftp -i wls-wdt-testkey-priv.txt -o ProxyCommand=\",ssh -i wls-wdt-testkey-priv.txt -W %h:%p ", "opc@", module.bastion.bastion_public_ip, "opc@", module.admin.admin_private_ip)
  file_permission = "700"
  filename        = "sftp_opc_admin.sh"
}
 
 

output "oke_cluster_id" {
  value = module.cluster.cluster_id
}

output "oke_cluster_name" {
  value = module.nodepool.cluster_name
}

output "oke_cluster_version" {
  value = module.nodepool.kubernetes_version
}

output "full_cluster_info" {
  value = module.cluster.full_cluster_info
}


output "wls-nodepool" {
  value = module.nodepool.wls-nodepool
}


output "non-wls-nodepool" {
  value = module.nodepool.wls-nodepool
}

output "all_node_pools" {
 value = module.nodepool.all_node_pools.node_pools.*.node_config_details[0].*.size
 }

resource "local_file" "kube_yaml" {
  ###depends_on = [ oci_core_instance.test_instance, null_resource.update_server ]
  content         = module.provisioner.kube_config.content
  file_permission = "700"
  filename        = "kube_config.yaml"
}




/*
output "jenkins_console_url" {
  value = "http://<internal_lb_ip>/jenkins"
}

output "weblogic_console_url" {
  value = "http://<internal_lb_ip>/console"
}

*/