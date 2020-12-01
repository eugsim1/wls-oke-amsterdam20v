# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

data "oci_core_internet_gateways" "internet_gateways" {
  #Required
  compartment_id = var.oci_network_vcn.compartment_id
  vcn_id         = local.vcn_id
}

data "oci_core_services" "all_oci_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}