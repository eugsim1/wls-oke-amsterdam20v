# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_containerengine_cluster" "k8s_cluster" {
 
  compartment_id     = var.oke_identity.compartment_id
  kubernetes_version = var.oke_cluster.cluster_kubernetes_version
  kms_key_id         = var.oke_cluster.use_encryption ? var.oke_cluster.vault_key_ocid : null
  name               = "${var.oke_general.label_prefix}-${var.oke_cluster.cluster_name}"

  options {
    add_ons {
      is_kubernetes_dashboard_enabled = var.oke_cluster.cluster_options_add_ons_is_kubernetes_dashboard_enabled
      is_tiller_enabled               = false
    }

    kubernetes_network_config {
      pods_cidr     = var.oke_cluster.cluster_options_kubernetes_network_config_pods_cidr
      services_cidr = var.oke_cluster.cluster_options_kubernetes_network_config_services_cidr
    }

    service_lb_subnet_ids = [var.oke_cluster.cluster_subnets["lb"]]
  }

  vcn_id = var.oke_cluster.vcn_id
  count = (var.oke_cluster.existing_cluster_id!="")?0:1
}
