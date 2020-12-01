# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.


resource "oci_core_service_gateway" "service_gateway" {
  compartment_id = var.oci_network_vcn.compartment_id
  display_name   = "${var.oci_network_vcn.label_prefix}-${var.oci_network_vcn.service_gateway_name}-gw"
  depends_on     = [oci_core_nat_gateway.nat_gateway]

  services {
    service_id = lookup(data.oci_core_services.all_oci_services.services[0], "id")
  }

  vcn_id = local.vcn_id

  #dont create ig if existing subnets are used
  count=var.oci_network_vcn.has_existing_subnets?0:(local.create_service_gateway ? local.has_no_existing_service_gw_id : 0)
}
