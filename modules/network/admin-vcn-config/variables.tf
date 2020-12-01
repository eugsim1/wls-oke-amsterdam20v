# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

variable "label_prefix" {}


# networking parameters
variable "admin_vcn_config" {
  type = object({
    compartment_id     = string
    subnet_cidr        = string
    ig_route_id        = string
    nat_route_id       = string
    vcn_id             = string
    existing_subnet_id = string
    admin_access_cidr  = string
    assign_public_ip   = bool
  })
}