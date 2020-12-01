# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  cluster_id = element(coalescelist(oci_containerengine_cluster.k8s_cluster.*.id, list(var.oke_cluster.existing_cluster_id)),0)
  cluster_ids=data.oci_containerengine_clusters.oke_clusters.clusters.*.id

  cluster_info=data.oci_containerengine_clusters.oke_clusters.clusters[index(local.cluster_ids,local.cluster_id)]
}