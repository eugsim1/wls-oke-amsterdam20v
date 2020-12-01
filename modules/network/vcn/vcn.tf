# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_core_vcn" "vcn" {
  cidr_block     = var.oci_network_vcn.vcn_cidr
  compartment_id = var.oci_network_vcn.compartment_id
  #optional
  display_name = "${var.oci_network_vcn.label_prefix}-vcn"
  dns_label    = "${var.oci_network_vcn.label_prefix}vcn"
  count        = local.has_no_existing_vcn
    lifecycle {
        ignore_changes = [ "freeform_tags" , "defined_tags",  ]
    }
	
}