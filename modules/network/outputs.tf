# Copyright  2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

output "ig_route_id" {
  value = module.vcn.ig_route_id
}

output "nat_route_id" {
  value = module.vcn.nat_route_id
}

output "vcn_id" {
  value = module.vcn.vcn_id
}

output "oke_subnet_ids" {
  value = module.oke-vcn-config.subnet_ids
}

output "bastion_subnet_id" {
  value = module.bastion-vcn-config.subnet_id
}

output "admin_subnet_id" {
  value = module.admin-vcn-config.admin_subnet_id
}

output "fss_subnet_id" {
  value = module.fss-vcn-config.subnet_id
}