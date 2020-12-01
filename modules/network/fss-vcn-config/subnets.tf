# Copyright  2019, Oracle Corporation and/or affiliates.  All rights reserved.


resource "oci_core_subnet" "fssubnets" {
    lifecycle {
        ignore_changes = [ "freeform_tags" , "defined_tags",  ]
    }
  count                      = var.fss_vcn_config.existing_fss_subnet_id == "" ? 1 : 0
  cidr_block                 = var.fss_vcn_config.fss_subnet_cidr
  compartment_id             = var.compartment_id
  display_name               = "${var.label_prefix}-fss"
  dns_label                  = "${var.label_prefix}fss"
  prohibit_public_ip_on_vnic = var.fss_vcn_config.private_subnet
  route_table_id             = var.fss_vcn_config.ig_route_id
  security_list_ids          = oci_core_security_list.fss_seclist.*.id
  vcn_id                     = var.fss_vcn_config.vcn_id
}