# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

output "vcn_id" {
  value = local.vcn_id
}

output "ig_route_id" {
  value = element(concat(oci_core_route_table.ig_route.*.id, list("")),0)
}

output "nat_route_id" {
  value = element(concat(oci_core_route_table.nat_route.*.id, list("")),0)
}