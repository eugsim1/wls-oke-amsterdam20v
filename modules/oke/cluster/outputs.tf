# Copyright  2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

output "cluster_id" {
    value = local.cluster_id
}

output "cluster_info" {
    value= local.cluster_info
}

output "full_cluster_info"  {
value = oci_containerengine_cluster.k8s_cluster
}