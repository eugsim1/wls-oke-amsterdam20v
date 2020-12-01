# Copyright 2019, 2020,  Oracle Corporation and/or affiliates.  All rights reserved.

# identity

variable "oke_identity" {
  type = object({
    compartment_id      = string
    tenancy_id          = string
    ssh_public_key      = string
    opc_ssh_private_key = string
    opc_ssh_public_key  = string
  })
}

# general oci

variable "oke_general" {
  type = object({
    label_prefix = string
    region       = string
  })
}

# oke

variable "oke_cluster" {
  type = object({
    cluster_kubernetes_version                              = string
    cluster_name                                            = string
    cluster_options_add_ons_is_kubernetes_dashboard_enabled = bool
    cluster_options_kubernetes_network_config_pods_cidr     = string
    cluster_options_kubernetes_network_config_services_cidr = string
    cluster_subnets                                         = map(string)
    vcn_id                                                  = string
    # encryption
    use_encryption                                          = bool
    vault_key_ocid                                          = string
    use_existing_cluster_id                                 = bool
  })
}

variable "node_pools" {
  type = object({
    node_pool_name_suffix      = string
    wls_node_pool_image_id     = string
    wls_node_pool_shape        = string
    wls_node_pool_count        = number
    non_wls_node_pool_image_id = string
    non_wls_node_pool_shape    = string
    non_wls_node_pool_count    = number
    node_pool_single_ad        = string
  })
}
variable "weblogic_image_tag" {}
variable "mode" {}
variable "cluster_info" {}