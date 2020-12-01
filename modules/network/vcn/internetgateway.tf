# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_core_internet_gateway" "ig" {
  compartment_id = var.oci_network_vcn.compartment_id
  display_name   = "${var.oci_network_vcn.label_prefix}-ig-gw"
  vcn_id         = local.vcn_id
  count          = local.has_no_existing_vcn
}

resource "oci_core_route_table" "ig_route" {
  compartment_id = var.oci_network_vcn.compartment_id
  display_name   = "${var.oci_network_vcn.label_prefix}-ig-route"

  route_rules {
    destination       = local.anywhere
    network_entity_id = local.ig_gw_id
  }

  dynamic "route_rules" {
    for_each = (var.oci_network_vcn.create_service_gateway == true && var.oci_network_vcn.create_nat_gateway == false) ? list(1) : []

    content {
      destination       = lookup(data.oci_core_services.all_oci_services[0].services[0], "cidr_block")
      destination_type  = "SERVICE_CIDR_BLOCK"
      network_entity_id = local.service_gw_id
    }
  }

  vcn_id = local.vcn_id

  #dont create ig if existing subnets are used
  count=var.oci_network_vcn.has_existing_subnets?0:1
}
