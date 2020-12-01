# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {

  has_oci_db_system_id = trimspace(var.oci_db_config.ocidb_dbsystem_id) != ""

  has_ocidb_compartment_id = trimspace(var.oci_db_config.ocidb_compartment_id)!=""
  has_ocidb_database_id    = trimspace(var.oci_db_config.ocidb_database_id) != ""
  has_oci_db_password = trimspace(var.oci_db_config.oci_db_password) != ""

  # oci db required params
  missing_oci_db_password      = (local.has_oci_db_system_id && !local.has_oci_db_password)
  missing_ocidb_compartment_id = (local.has_oci_db_system_id && !local.has_ocidb_compartment_id)
  missing_ocidb_database_id    = (local.has_oci_db_system_id && !local.has_ocidb_database_id)
//  missing_ocidb_vcn_id       = (local.has_oci_db_system_id && var.oci_db_config.ocidb_existing_vcn_id=="")

  # Check for missing required params
  missing_oci_db_password_msg = "WLSOKE-ERROR:  The value for DB System Admin Password [ oci_db_password ] is required."
  validate_missing_oci_db_password = local.missing_oci_db_password ? local.validators_msg_map[local.missing_oci_db_password_msg] : null

  missing_ocidb_compartment_id_msg = "WLSOKE-ERROR: The value for [ocidb_compartment_id] is required."
  validate_missing_ocidb_compartment_id = local.missing_ocidb_compartment_id ? local.validators_msg_map[local.missing_ocidb_compartment_id_msg] : null

  missing_ocidb_database_id_msg = "WLSOKE-ERROR: The value for [ocidb_database_id] is required."
  validate_missing_ocidb_database_id = local.missing_ocidb_database_id ? local.validators_msg_map[local.missing_ocidb_database_id_msg] : null

  #OCID validation
  invalid_oci_db_password_msg  = "WLSOKE-ERROR: The value for DB System Admin Password [oci_db_password_ocid] is not valid. The value must begin with ocid1 followed by resource type, e.g. ocid1.vaultsecret."
  validate_oci_db_password      = local.has_oci_db_password ? length(regexall("^ocid1.vaultsecret.", var.oci_db_config.oci_db_password)) > 0 ? null : local.validators_msg_map[local.invalid_oci_db_password_msg] : null

//  missing_ocidb_vcn_id_msg = "WLSOKE-ERROR: The value for [ocidb_existing_vcn_id] is required."
//  validate_missing_ocidb_vcn_id = local.missing_ocidb_vcn_id ? local.validators_msg_map[local.missing_ocidb_vcn_id_msg] : null


  # 2. Selected DB System VCN and WLS VCN are not same - in V1 release we dont support automation of VCN peering so
  # restrict the user to select a DB in same VCN as WLS.

//  has_wls_existing_vcn = trimspace(var.oci_network_vcn.existing_vcn_id) != ""
//  has_wls_new_vcn = trimspace(var.oci_network_vcn.existing_vcn_id) == ""
//  invalid_ocidb_vcn1 = local.has_oci_db_system_id && local.has_wls_existing_vcn ? var.oci_db_config.ocidb_existing_vcn_id != var.oci_network_vcn.existing_vcn_id: false
//  invalid_ocidb_vcn2 = local.has_oci_db_system_id && local.has_wls_new_vcn
//  invalid_vcn_msg = "WLSOKE-ERROR: DB System cannot be used when WLS VCN is not same as DB System's VCN"
//  validate_ocidb_vcn = local.invalid_ocidb_vcn1 || local.invalid_ocidb_vcn2 ? local.validators_msg_map[local.invalid_vcn_msg] : null

}