# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

#SET THIS TRUE FOR MARKETPLACE LISTING
variable "use_bastion_marketplace_image" {
  type        = bool
  description = "use bastion marketplace image"
  default     = true
}

variable "use_admin_marketplace_image" {
  type        = bool
  description = "use admin marketplace image"
  default     = true
}

variable "use_nodepool_marketplace_image" {
  type        = bool
  description = "use nodepool marketplace image"
  default     = true
}

variable "admin_image_id" {
  description = "ocid admin image"
  type        = string
  default     = "ocid1.image.oc1..aaaaaaaabyizs5d7olwpd77wzycin4zdn5uk2cx2zpx2peuzwfw7vaesmmda"
}

variable "mp_admin_listing_id" {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaali6fqhd2kf3ee6bvqekiwnrsz24va4molvqmbrtxvgnlgqhbcpvq"
}

variable "mp_admin_listing_resource_version" {
  default = "20.4.2-201113215052"
}

variable "bastion_image_id" {
  description = "bastion image id"
  type        = string
  default     = "ocid1.image.oc1..aaaaaaaatbokpfj2x3oio7ibv7tuzl3twuqpfeuwq4xcy4xr6hekjzuccuza"
}

variable "mp_bastion_listing_id" {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaacicjx6jviqczqow567tadr5ju7iy2m4vx6opyra6thql55n2nnvq"
}

variable "mp_bastion_listing_resource_version" {
  default = "19.3.3-190816034153"
}

#These values change based on SUITE edition or EE edition
variable "mp_wls_node_pool_image_id" {
  description = "nodepool image id"
  type        = string
  default     = "ocid1.image.oc1..aaaaaaaaibbsg23uasf77j4kdldnjnbmgkfjxd5gqywabs3hwx2jw45pj24q"
}

variable "mp_wls_node_pool_listing_id" {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaabw6dti6ejlfe4h5vcdtuemmzcbxc6myje2t4au6fox5excyiy2ma"
}

variable "mp_wls_node_pool_listing_resource_version" {
  default = "20.4.1-200917030044-092120202314"
}
