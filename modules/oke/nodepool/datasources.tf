# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

data "oci_containerengine_cluster_option" "k8s_cluster_option" {
  #Required
  cluster_option_id = "all"
}

data "oci_containerengine_node_pools" "all_node_pools" {
  compartment_id = var.oke_identity.compartment_id
  cluster_id     = var.cluster_info["id"]
  depends_on     = [oci_containerengine_node_pool.wls-nodepool, oci_containerengine_node_pool.non-wls-nodepool]
}

data "oci_identity_availability_domains" "ad_list" {
  compartment_id = var.oke_identity.tenancy_id
}

data "template_file" "ad_names" {
  count    = length(data.oci_identity_availability_domains.ad_list.availability_domains)
  template = lookup(data.oci_identity_availability_domains.ad_list.availability_domains[count.index], "name")
}


