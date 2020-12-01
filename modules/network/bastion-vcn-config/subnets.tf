# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_core_subnet" "bastion_subnet" {
  compartment_id             = var.bastion_vcn_config.compartment_id
  cidr_block                 = var.bastion_vcn_config.subnet_cidr
  display_name               = "${var.label_prefix}-bastion"
  dns_label                  = "${var.label_prefix}bastion"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = var.bastion_vcn_config.ig_route_id
  security_list_ids          = oci_core_security_list.bastion_security_list.*.id
  vcn_id                     = var.bastion_vcn_config.vcn_id

  count = var.bastion_vcn_config.existing_subnet_id=="" ? 1 : 0
}
