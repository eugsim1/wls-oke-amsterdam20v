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
    existing_cluster_id                                     = string
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

  })
}

variable "weblogic_image_tag" {}
variable "mode" {}