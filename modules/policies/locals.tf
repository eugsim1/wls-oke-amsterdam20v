# Copyright  2019, 2020 Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

locals {
  dynamic_group_name = var.create_policies ? oci_identity_dynamic_group.oke_admin_instance_principal_group[0].name : ""

  #Policy Statements
  oke_policy_statement = "Allow service OKE to read app-catalog-listing in compartment id ${var.oci_identity.compartment_id}"
  ss_policy_statement1 = var.create_policies ? "Allow dynamic-group ${local.dynamic_group_name} to read secret-bundles in tenancy where target.secret.id = '${var.oci_wls_secrets.wls_admin_password_secret_ocid}'" : ""
  ss_policy_statement2 = var.create_policies ? "Allow dynamic-group ${local.dynamic_group_name} to read secret-bundles in tenancy where target.secret.id = '${var.oci_wls_secrets.ocir_auth_token_secret_ocid}'" : ""
  ss_policy_statement3 = var.create_policies && var.oci_wls_secrets.db_password_secret_ocid !="" ? "Allow dynamic-group ${local.dynamic_group_name} to read secret-bundles in tenancy where target.secret.id = '${var.oci_wls_secrets.db_password_secret_ocid}'" : ""
  ss_policy_statement4 = var.create_policies && var.oke_secret_enc.use_encryption ? "Allow dynamic-group ${local.dynamic_group_name} to use key in tenancy where target.key.id = '${var.oke_secret_enc.key_ocid}'" : ""
  atp_policy_statement = var.create_policies && var.is_atp ? "Allow dynamic-group ${local.dynamic_group_name} to use autonomous-transaction-processing-family in compartment id ${var.atp_compartment_id}" : ""
  admin_res_policy_statement = var.create_policies ? "Allow dynamic-group ${local.dynamic_group_name} to manage all-resources in compartment id ${var.oci_identity.compartment_id}" : ""
  admin_grp_policy_statement = var.create_policies ? "Allow dynamic-group ${local.dynamic_group_name} to use dynamic-groups in tenancy" : ""

  policy_statements = compact([local.oke_policy_statement, local.ss_policy_statement1, local.ss_policy_statement2, local.ss_policy_statement3, local.ss_policy_statement4, local.atp_policy_statement, local.admin_res_policy_statement, local.admin_grp_policy_statement])
}
