# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_core_subnet" "oke_workers_subnet" {
  cidr_block                 = var.oke_vcn_config.oke_workers_subnet_cidr
  compartment_id             = var.compartment_id
  display_name               = "${var.label_prefix}-workers"
  dns_label                  = "${var.label_prefix}worker"
  prohibit_public_ip_on_vnic = var.oke_vcn_config.worker_mode == "private" ? true : false
  route_table_id             = var.oke_vcn_config.worker_mode == "private" ? var.oke_vcn_config.nat_route_id : var.oke_vcn_config.ig_route_id
  security_list_ids          = var.oke_vcn_config.worker_mode == "private" ? oci_core_security_list.private_workers_seclist.*.id : oci_core_security_list.public_workers_seclist.*.id
  vcn_id                     = var.oke_vcn_config.vcn_id
  count = local.has_existing_oke_workers_subnet_id?0:1
}

resource "oci_core_subnet" "lb_subnet" {
  cidr_block                 = var.oke_vcn_config.lb_subnet_cidr
  compartment_id             = var.compartment_id
  display_name               = "${var.label_prefix}-lb"
  dns_label                  = "${var.label_prefix}lb"
  prohibit_public_ip_on_vnic = var.oke_vcn_config.private_lb
  route_table_id             = var.oke_vcn_config.ig_route_id
  security_list_ids          = oci_core_security_list.lb_seclist.*.id
  vcn_id                     = var.oke_vcn_config.vcn_id

  count = local.has_existing_lb_subnet_id?0:1
}
