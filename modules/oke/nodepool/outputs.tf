# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

output "kubernetes_version" {
  value = local.kubernetes_version
}

output "cluster_name" {
  value = local.cluster_name
}


output "wls-nodepool" {
value = oci_containerengine_node_pool.wls-nodepool
}


output "non-wls-nodepool" {
value = oci_containerengine_node_pool.wls-nodepool
}


output "all_node_pools" {
value = data.oci_containerengine_node_pools.all_node_pools
}