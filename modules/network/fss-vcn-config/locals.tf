# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

data "oci_core_vcn" "oke_vcn" {
  #Required
  vcn_id = var.fss_vcn_config.vcn_id
}

locals {
  anywhere="0.0.0.0/0"
  vcn_cidr= data.oci_core_vcn.oke_vcn.cidr_block
  subnet_id=element(coalescelist(oci_core_subnet.fssubnets.*.id, list(var.fss_vcn_config.existing_fss_subnet_id)),0)
}
