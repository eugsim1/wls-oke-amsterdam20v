# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_core_subnet" "admin_subnet" {
    lifecycle {
        ignore_changes = [ "freeform_tags" , "defined_tags",  ]
    }
  compartment_id             = var.admin_vcn_config.compartment_id
  cidr_block                 = var.admin_vcn_config.subnet_cidr
  display_name               = "${var.label_prefix}-admin"
  dns_label                  = "${var.label_prefix}admin"
  prohibit_public_ip_on_vnic = local.private_subnet
  route_table_id             = local.private_subnet?var.admin_vcn_config.nat_route_id: var.admin_vcn_config.ig_route_id
  security_list_ids          = oci_core_security_list.admin_security_list.*.id
  vcn_id                     = var.admin_vcn_config.vcn_id

  count = var.admin_vcn_config.existing_subnet_id=="" ? 1 : 0
}
