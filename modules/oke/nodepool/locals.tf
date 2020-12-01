# Copyright  2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

locals {
  kubernetes_version=var.cluster_info["kubernetes_version"]
  cluster_name=var.cluster_info["name"]

  node_pools_size_list = [
   for node_pool in data.oci_containerengine_node_pools.all_node_pools.node_pools :
    node_pool.node_config_details[0]
  ]

  #workaround for summing a list of numbers: https://github.com/hashicorp/terraform/issues/17239
#######  total_nodes = length(flatten([
#######  for nodes in local.node_pools_size_list : range(nodes)
#######  ]))
     total_nodes = 2##sum (local.node_pools_size_list)

  ad_names = var.mode == "DEV" && length(var.node_pools.node_pool_single_ad) > 0 ? list(var.node_pools.node_pool_single_ad) : data.template_file.ad_names.*.rendered
}
