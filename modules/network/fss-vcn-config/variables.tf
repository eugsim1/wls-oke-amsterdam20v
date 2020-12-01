# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.

# Identity and access parameters
variable "compartment_id" {}
variable "label_prefix" {}

# networking parameters
variable "fss_vcn_config" {
  type = object({
    fss_subnet_cidr        = string
    ig_route_id            = string
    vcn_id                 = string
    existing_fss_subnet_id = string
    availability_domain    = string
    private_subnet         = bool
  })
}
