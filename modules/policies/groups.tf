# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_identity_dynamic_group" "oke_admin_instance_principal_group" {
  count = var.create_policies ? 1 : 0
  compartment_id = var.oci_identity.tenancy_id
  description    = "dynamic group to allow admin instance to call services"
  matching_rule  = "ALL {instance.compartment.id = '${var.oci_identity.compartment_id}'}"
  name           = "${var.label_prefix}-admin-instance-principal-group"

  lifecycle {
    ignore_changes = [matching_rule]
  }
}


