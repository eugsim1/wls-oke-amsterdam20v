# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

variable "oci_network_vcn" {
  type = object({
    compartment_id                = string
    label_prefix                  = string
    create_nat_gateway            = bool
    nat_gateway_name              = string
    create_service_gateway        = bool
    service_gateway_name          = string
    vcn_cidr                      = string
    existing_vcn_id               = string
    existing_nat_gw_id            = string
    existing_service_gw_id        = string
    has_existing_subnets          = bool
  })
}
