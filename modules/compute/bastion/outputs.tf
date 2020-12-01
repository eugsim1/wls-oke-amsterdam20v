# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

output "bastion_id" {
  value = oci_core_instance.bastion.id
}

output "bastion_public_ip" {
  value = oci_core_instance.bastion.public_ip
}

output "bastion_private_ip" {
  value = oci_core_instance.bastion.private_ip
}
