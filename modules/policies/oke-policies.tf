# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_identity_policy" "oke-policy" {
  count = var.create_policies ? 1 : 0
  compartment_id = var.oci_identity.tenancy_id
  description    = "Policy required for WLS on OKE"
  name           = "${var.label_prefix}-oke-policy"
  statements     = local.policy_statements
}
