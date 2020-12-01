# Copyright  2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

#Contains only OKE variables

variable "cluster_name" {
  description = "name of oke cluster"
  default     = ""
}

variable "dashboard_enabled" {
  description = "whether to enable kubernetes dashboard"
  default     = false
}

variable "kubernetes_version" {
  description = "version of kubernetes to use"
  default     = "v1.17.9"
}

variable "wls_node_pool_shape" {
  type        = string
  description = "shape of worker nodes"
  default     = "VM.Standard2.1"
}

variable "wls_node_pool_count" {
  type        = number
  description = "number of nodes in the weblogic node pool"
  default     = "1"
}

# Using bastion PIC image viz. OL 7.6
# Using https://docs.cloud.oracle.com/iaas/images/image/ca429258-2487-45da-a540-2df4142583b5/
# Oracle-provided image = Oracle-Linux-7.6-2019.06.15-0
variable "wls_node_pool_image_id" {
  description = "OCID of custom image to use for worker node"
  default     = "ocid1.image.oc1..aaaaaaaatbokpfj2x3oio7ibv7tuzl3twuqpfeuwq4xcy4xr6hekjzuccuza"
}

variable "non_wls_node_pool_shape" {
  type        = string
  description = "shape of worker nodes"
  default     = "VM.Standard2.1"
}

variable "non_wls_node_pool_count" {
  type        = number
  description = "number of nodes in the non-weblogic node pool"
  default     = "1"
}

# Using bastion PIC image viz. OL 7.6
# Using https://docs.cloud.oracle.com/iaas/images/image/ca429258-2487-45da-a540-2df4142583b5/
# Oracle-provided image = Oracle-Linux-7.6-2019.06.15-0
variable "non_wls_node_pool_image_id" {
  description = "OCID of custom image to use for worker node"
  default     = "ocid1.image.oc1..aaaaaaaatbokpfj2x3oio7ibv7tuzl3twuqpfeuwq4xcy4xr6hekjzuccuza"
}

variable "node_pool_name_suffix" {
  description = "suffix of node pool name"
  default     = "np"
}

variable "pods_cidr" {
  description = "This is the CIDR range used for IP addresses by your pods. A /16 CIDR is generally sufficient. This CIDR should not overlap with any subnet range in the VCN (it can also be outside the VCN CIDR range)."
  default     = "10.244.0.0/16"
}

variable "services_cidr" {
  description = "This is the CIDR range used by exposed Kubernetes services (ClusterIPs). This CIDR should not overlap with the VCN CIDR range."
  default     = "10.96.0.0/16"
}

variable "worker_mode" {
  description = "whether to provision public or private workers"
  default     = "private"
}

variable "existing_cluster_id" {
  description = "existing cluster id"
  default     = ""
}

# Enable vault key for encryption in OKE cluster
variable "use_encryption" {
  description = "Enable encryption by using the master encryption key in Vault. If you do not select this option, the standard block storage encryption is used for etcd read/write and Kubernetes secrets at rest in etcd are not encrypted."
  default     = false
  type        = bool
}

variable "vault_key_ocid" {
  description = "Key OCID for Kubernetes secret encryption"
  default     = ""
  type        = string
}