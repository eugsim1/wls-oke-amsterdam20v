# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  anywhere                   = "0.0.0.0/0"
  has_no_existing_service_gw_id = var.oci_network_vcn.existing_service_gw_id == "" ? 1 : 0
  has_no_existing_nat_gw_id     = var.oci_network_vcn.existing_nat_gw_id == "" ? 1 : 0
  has_no_existing_vcn           = var.oci_network_vcn.existing_vcn_id == "" ? 1 : 0
  vcn_id                     = element(coalescelist(oci_core_vcn.vcn.*.id, compact(list(var.oci_network_vcn.existing_vcn_id)),list("")), 0)

  ig_routing_table_id  = oci_core_route_table.ig_route.*.id
  nat_routing_table_id = oci_core_route_table.nat_route.*.id

  ig_gw_id      = element(concat(oci_core_internet_gateway.ig.*.id, data.oci_core_internet_gateways.internet_gateways.gateways.*.id), 0)
  nat_gw_id     = element(concat(oci_core_nat_gateway.nat_gateway.*.id, list(var.oci_network_vcn.existing_nat_gw_id)), 0)
  service_gw_id = element(concat(oci_core_service_gateway.service_gateway.*.id, list(var.oci_network_vcn.existing_service_gw_id)), 0)

  #for existing vcn only, do not create service gateway if nat gateway is already configured
  create_service_gateway=((var.oci_network_vcn.existing_service_gw_id!="" || var.oci_network_vcn.existing_nat_gw_id!="") && var.oci_network_vcn.existing_vcn_id!="")?false:true

  #for existing vcn only, do not create nat gateway if service gateway is already configured
  create_nat_gateway=((var.oci_network_vcn.existing_service_gw_id!="" || var.oci_network_vcn.existing_nat_gw_id!="") && var.oci_network_vcn.existing_vcn_id!="")?false:true
}