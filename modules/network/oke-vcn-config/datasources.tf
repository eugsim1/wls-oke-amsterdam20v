# Copyright 2017, 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

data "oci_core_services" "all_oci_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
  count = var.oke_vcn_config.is_service_gateway_enabled == true ? 1 : 0
}

data "oci_core_subnets" "oke_subnets" {
  compartment_id = var.compartment_id
  vcn_id         = var.oke_vcn_config.vcn_id

  filter {
    name   = "state"
    values = ["AVAILABLE"]
  }
}
