# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

output "subnet_id" {
  value = local.bastion_subnet_id
}

output "subnet_cidr" {
  value = data.oci_core_subnet.bastion_subnet.cidr_block
}