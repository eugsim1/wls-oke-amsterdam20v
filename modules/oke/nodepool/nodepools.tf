# Copyright  2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_containerengine_node_pool" "wls-nodepool" {


  cluster_id         = var.cluster_info["id"]
  compartment_id     = var.oke_identity.compartment_id
  kubernetes_version = local.kubernetes_version
  name               = "${var.oke_general.label_prefix}-wls-${var.node_pools.node_pool_name_suffix}"

  initial_node_labels {
    #Optional
    key   = "usage"
    value = "weblogic"
  }

  initial_node_labels {
    #Optional
    key   = "node-pool"
    value = "wls-nodepool"
  }
  
  node_config_details {

    dynamic "placement_configs" {
      iterator = ad_iterator
      for_each = local.ad_names
      content {
        availability_domain = ad_iterator.value
        subnet_id           = var.oke_cluster.cluster_subnets["workers"]
      }
    }
    size = var.node_pools.wls_node_pool_count
  }

  node_source_details {
    #Required
    image_id    = var.node_pools.wls_node_pool_image_id
    source_type = "IMAGE"
  }

  node_metadata = {
    hostclass = "WLSOKE"
    user_data = data.template_cloudinit_config.nodepool-config.rendered
  }

  node_shape = var.node_pools.wls_node_pool_shape

  ssh_public_key = var.oke_identity.opc_ssh_public_key
}

resource "oci_containerengine_node_pool" "non-wls-nodepool" {


  cluster_id         = var.cluster_info["id"]
  compartment_id     = var.oke_identity.compartment_id
  kubernetes_version = local.kubernetes_version
  name               = "${var.oke_general.label_prefix}-non-wls-${var.node_pools.node_pool_name_suffix}"

  initial_node_labels {
    #Optional
    key   = "usage"
    value = "jenkins"
  }

  initial_node_labels {
    #Optional
    key   = "usage1"
    value = "nginx"
  }
  
    initial_node_labels {
    #Optional
    key   = "node-pool"
    value = "non-wls-nodepool"
  }

  node_config_details {

    dynamic "placement_configs" {
      iterator = ad_iterator
      for_each = local.ad_names
      content {
        availability_domain = ad_iterator.value
        subnet_id           = var.oke_cluster.cluster_subnets["workers"]
      }
    }
    size = var.node_pools.non_wls_node_pool_count
  }

  node_source_details {
    #Required
    image_id    = var.node_pools.non_wls_node_pool_image_id
    source_type = "IMAGE"
  }

  # Added as per https://confluence.oci.oraclecorp.com/pages/viewpage.action?spaceKey=OKE&title=OKE+Implementation+Guide+for+OCI+Native+teams
  node_metadata = {
    hostclass = "WLSOKE"
    user_data = data.template_cloudinit_config.nodepool-config.rendered
  }

  node_shape = var.node_pools.non_wls_node_pool_shape

  ssh_public_key = var.oke_identity.opc_ssh_public_key
}
