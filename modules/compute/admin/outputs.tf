# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

output "admin_public_ip" {
  value = oci_core_instance.admin.public_ip
}

output "admin_private_ip" {
  value = oci_core_instance.admin.private_ip
}

output "admin_id" {
  value = oci_core_instance.admin.id
}

