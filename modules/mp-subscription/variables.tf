# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.


variable "bastion_mp_subscription" {
  type = object({
    compartment_id              = string
    mp_listing_id               = string
    mp_listing_resource_version = string
    use_marketplace_image       = bool
  })
}

variable "admin_mp_subscription" {
  type = object({
    compartment_id              = string
    mp_listing_id               = string
    mp_listing_resource_version = string
    use_marketplace_image       = bool
  })
}

variable "nodepool_mp_subscription" {
  type = object({
    compartment_id              = string
    mp_listing_id               = string
    mp_listing_resource_version = string
    use_marketplace_image       = bool
  })
}
