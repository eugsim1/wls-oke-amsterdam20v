# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  supported_kubernetes_versions  = ["v1.16.8", "v1.17.9", "v1.18.10" ]
  invalid_kubernetes_version     = ! contains(local.supported_kubernetes_versions, var.oke_cluster_config.cluster_kubernetes_version)
  invalid_kubernetes_version_msg = "WLSOKE-ERROR: The value for kubernetes_version=[${var.oke_cluster_config.cluster_kubernetes_version}] is not valid. The permissible values are [${join(", ", local.supported_kubernetes_versions)}]"
  validate_kubernetes_version    = local.invalid_kubernetes_version ? local.validators_msg_map[local.invalid_kubernetes_version_msg] : null

  #KMS validation
  has_vault_key_ocid            = var.oke_secret_enc.key_ocid != ""
  missing_vault_key_ocid        = var.oke_secret_enc.use_encryption ? ! local.has_vault_key_ocid : false
  missing_vault_key_ocid_msg    = "WLSOKE-ERROR:  The value for Vault key [ vault_key_ocid ] is required."
  validate_missing_kms_key_id   = local.missing_vault_key_ocid ? local.validators_msg_map[local.missing_vault_key_ocid_msg] : null

  #OCID validation
  invalid_vault_key_msg         = "WLSOKE-ERROR: The value for Vault Key [vault_key_ocid] is not valid. The value must begin with ocid1 followed by resource type, e.g. ocid1.key."
  invalid_vault_key             = local.has_vault_key_ocid ? length(regexall("^ocid1.key.", var.oke_secret_enc.key_ocid)) > 0 ? null : local.validators_msg_map[local.invalid_vault_key_msg] : null
}