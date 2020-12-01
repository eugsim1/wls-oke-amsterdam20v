# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

output "admin_dynamic_group_id" {
  value = var.create_policies ? oci_identity_dynamic_group.oke_admin_instance_principal_group[0].id: ""
}

output "oke_policy_id" {
  value = var.create_policies ? element(concat(oci_identity_policy.oke-policy[0].*.id, list("")),0): ""
}
