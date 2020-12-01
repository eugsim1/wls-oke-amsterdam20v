# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = var.oci_network_vcn.compartment_id
  display_name   = "${var.oci_network_vcn.label_prefix}-${var.oci_network_vcn.nat_gateway_name}-gw"
  vcn_id         = local.vcn_id
  count          = var.oci_network_vcn.has_existing_subnets?0:(local.create_nat_gateway? local.has_no_existing_nat_gw_id : 0)
}

resource "oci_core_route_table" "nat_route" {
  compartment_id = var.oci_network_vcn.compartment_id
  display_name   = "${var.oci_network_vcn.label_prefix}-nat-route"

  dynamic "route_rules" {
    for_each = local.nat_gw_id!=""? list(1) : []

    content {
      destination       = local.anywhere
      destination_type  = "CIDR_BLOCK"
      network_entity_id = local.nat_gw_id
    }
  }

  dynamic "route_rules" {
    for_each = local.service_gw_id!=""? list(1) : []

    content {
      destination       = lookup(data.oci_core_services.all_oci_services.services[0], "cidr_block")
      destination_type  = "SERVICE_CIDR_BLOCK"
      network_entity_id = local.service_gw_id
    }
  }

  vcn_id = local.vcn_id

  #dont create nat route if existing subnets are used
  count=(var.oci_network_vcn.has_existing_subnets?0: 1)
}