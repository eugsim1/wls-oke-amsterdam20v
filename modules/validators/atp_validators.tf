# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {

  has_atp_db_id         = trimspace(var.atp_db_config.atp_db_id) != ""
  has_atp_db_password   = trimspace(var.atp_db_config.atp_db_password) != ""?true:false
  has_atp_comparment_id = trimspace(var.atp_db_config.atp_db_compartment_id) != ""


  # 1. Missing ATP DB Password
  missing_atp_db_password_msg      = "WLSOKE-ERROR:  The value for ATP DB Admin Password [ atp_db_password ] is required."
  validate_missing_atp_db_password = local.has_atp_db_id && ! local.has_atp_db_password ? local.validators_msg_map[local.missing_atp_db_password_msg] : null

  # 2. Missing ATP compartment
  missing_atp_compartment_id_msg = "WLSOKE-ERROR: The value of ATP DB compartment [ atp_db_compartment_id ] is required."
  validate_atp_compartment_id =  local.has_atp_db_id && ! local.has_atp_comparment_id ? local.validators_msg_map[local.missing_atp_compartment_id_msg] : null

  # 3. Validate ATP DB Service level
  invalid_atp_db_level     = local.has_atp_db_id && ! contains(list("low", "tp", "tpurgent"), var.atp_db_config.atp_db_level)
  invalid_atp_db_level_msg = "WLSOKE-ERROR: The value for atp_db_level=[${var.atp_db_config.atp_db_level}] is not valid. The permissible values are [low, tp, tpurgent]"
  validate_atp_db_level    = local.invalid_atp_db_level ? local.validators_msg_map[local.invalid_atp_db_level_msg] : null

  #OCID validation
  invalid_atp_db_password_msg  = "WLSOKE-ERROR: The value for ATP DB Admin Password [atp_db_password_ocid] is not valid. The value must begin with ocid1 followed by resource type, e.g. ocid1.vaultsecret."
  validate_atp_db_password      = local.has_atp_db_password ? length(regexall("^ocid1.vaultsecret.", var.atp_db_config.atp_db_password)) > 0 ? null : local.validators_msg_map[local.invalid_atp_db_password_msg] : null
}