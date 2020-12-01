
# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  has_existing_oke_workers_subnet_id = var.oke_vcn_config.existing_oke_workers_subnet_id != ""
  has_existing_lb_subnet_id = var.oke_vcn_config.existing_lb_subnet_id != ""
  has_existing_bastion_subnet_id=var.bastion_vcn_config.existing_subnet_id != ""
  has_existing_admin_subnet_id = var.admin_vcn_config.existing_subnet_id != ""
  has_fss_subnet_id = var.fss_vcn_config.existing_subnet_id != ""
  has_existing_vcn_id = var.oci_network_vcn.existing_vcn_id != ""

  # if existing subnet is used then existing vcn has to be passed
  missing_vcn_id_message = "WLSOKE-ERROR: Existing vcn id is required if existing subnets are used for provisioning"
  validate_missing_vcn_id = (! local.has_existing_vcn_id && (local.has_existing_oke_workers_subnet_id || local.has_existing_lb_subnet_id || local.has_existing_admin_subnet_id || local.has_existing_bastion_subnet_id || local.has_fss_subnet_id)) ? local.validators_msg_map[local.missing_vcn_id_message] : null

  # if one existing subnet is used then, use existing subnets for rest of the subnets.
  missing_existing_subnet_ids = "WLSOKE-ERROR: Existing subnet ids are required for all the subnets [existing_oke_workers_subnet_id, existing_lb_subnet_id, existing_bastion_subnet_id , existing_admin_subnet_id]."

  has_all_existing_oke_subnet_ids = (local.has_existing_oke_workers_subnet_id && local.has_existing_lb_subnet_id && local.has_fss_subnet_id)
  is_existing_subnets_used = (local.has_existing_oke_workers_subnet_id || local.has_existing_lb_subnet_id || local.has_existing_bastion_subnet_id ||  local.has_existing_admin_subnet_id)

  #check all subnets id are provided
  validate_missing_subnet_ids = (! local.is_existing_subnets_used || (local.has_all_existing_oke_subnet_ids && local.has_existing_admin_subnet_id && local.has_existing_bastion_subnet_id)) ? null : local.validators_msg_map[local.missing_existing_subnet_ids]

  #nat gw  id for existing vcn only
  missing_nat_or_service_gw_id = "WLSOKE-ERROR: For existing vcn, either service or nat gateway [existing_nat_gw_id or existing_service_gw_id] is required."
  has_existing_nat_gw_id = (var.oci_network_vcn.existing_nat_gw_id == "") ? false : true
  missing_nat_gw_id = (local.has_existing_vcn_id && ! local.has_existing_nat_gw_id)

  #service gw  id for existing vcn only
  has_existing_srv_gw_id = (var.oci_network_vcn.existing_service_gw_id == "") ? false : true
  missing_service_gw_id=(local.has_existing_vcn_id && ! local.has_existing_srv_gw_id)

  validate_missing_service_gw_id = (local.missing_service_gw_id && local.missing_nat_gw_id)? local.validators_msg_map[local.missing_nat_or_service_gw_id] : null

  #cidr validations
  has_bastion_subnet_cidr = local.has_existing_bastion_subnet_id ? true : (var.bastion_vcn_config.subnet_cidr != "")
  has_admin_subnet_cidr = local.has_existing_admin_subnet_id ? true : (var.admin_vcn_config.subnet_cidr != "")
  has_worker_subnet_cidr = local.has_existing_oke_workers_subnet_id ? true : (var.oke_vcn_config.oke_workers_subnet_cidr != "")
  has_lb_subnet_cidr = local.has_existing_lb_subnet_id ? true : (var.oke_vcn_config.lb_subnet_cidr != "")
  has_fss_subnet_cidr = local.has_fss_subnet_id ? true : (var.fss_vcn_config.subnet_cidr != "")

  missing_bastion_subnet_cidr = "WLSOKE-ERROR: Bastion subnet CIDR  [bastion_subnet_cidr] value is required."
  missing_admin_subnet_cidr = "WLSOKE-ERROR: Admin subnet CIDR  [admin_subnet_cidr] value is required."
  missing_worker_subnet_cidr = "WLSOKE-ERROR: Worker subnet CIDR  [oke_workers_subnet_cidr] value is required."
  missing_lb_subnet_cidr = "WLSOKE-ERROR: Load balancer subnet CIDR [lb_subnet_cidr] value is required."
  missing_fss_subnet_cidr = "WLSOKE-ERROR: FSS subnet CIDR [fss_subnet_cidr] is required."

  validate_missing_fss_subnet_cidr = local.has_fss_subnet_cidr  || local.is_existing_subnets_used ? null : local.validators_msg_map[local.missing_fss_subnet_cidr]
  validate_missing_admin_subnet_cidr = local.has_admin_subnet_cidr  || local.is_existing_subnets_used ? null : local.validators_msg_map[local.missing_admin_subnet_cidr]
  validate_missing_bastion_subnet_cidr = local.has_bastion_subnet_cidr || local.is_existing_subnets_used ? null : local.validators_msg_map[local.missing_bastion_subnet_cidr]
  validate_missing_worker_subnet_cidr = local.has_worker_subnet_cidr  || local.is_existing_subnets_used ? null : local.validators_msg_map[local.missing_worker_subnet_cidr]
  validate_missing_lb_subnet_cidr = local.has_lb_subnet_cidr  || local.is_existing_subnets_used? null : local.validators_msg_map[local.missing_lb_subnet_cidr]

  #mount target validation
  missing_fss_subnet_id_with_mount_target="WLSOKE-ERROR: Mount target id can only be used with existing subnets."
  has_mount_target_id= var.existing_mount_target_id!=""
  validate_missing_fss_subnet_id_with_mount_target = local.has_mount_target_id && !local.has_fss_subnet_id? local.validators_msg_map[local.missing_fss_subnet_id_with_mount_target]: null

  invalid_mountTarget_vcn = var.mountTarget_vcn_id != "" && var.oci_network_vcn.existing_vcn_id != "" && var.oci_network_vcn.existing_vcn_id != var.mountTarget_vcn_id
  invalid_mountTarget_vcn_msg = "WLSOKE-ERROR: MountTarget and the OKE nodes should be in the same VCN"
  validate_mountTarget_vcn = local.invalid_mountTarget_vcn ? local.validators_msg_map[local.invalid_mountTarget_vcn_msg] : null

  #OCID validations
  invalid_mountTarget_msg = "WLSOKE-ERROR: The value for existing mount target id [mountTarget_id] is not valid. The value must begin with ocid1 followed by resource type, e.g. ocid1.mounttarget."
  validate_mountTarget_id = local.has_mount_target_id && local.has_fss_subnet_id ? length(regexall("^ocid1.mounttarget.", var.existing_mount_target_id)) > 0 ? null : local.validators_msg_map[local.invalid_mountTarget_msg] : null

  invalid_nat_gw_msg  = "WLSOKE-ERROR: The value for existing nat gateway id [existing_nat_gw_id] is not valid. The value must begin with ocid1 followed by resource type, e.g. ocid1.natgateway."
  validate_nat_gw_id  = local.has_existing_nat_gw_id ? length(regexall("^ocid1.natgateway.", var.oci_network_vcn.existing_nat_gw_id)) > 0 ? null : local.validators_msg_map[local.invalid_nat_gw_msg] : null

  invalid_srv_gw_msg  = "WLSOKE-ERROR: The value for existing service gateway id [existing_service_gw_id] is not valid. The value must begin with ocid1 followed by resource type, e.g. ocid1.servicegateway."
  validate_srv_gw_id  = local.has_existing_srv_gw_id ? length(regexall("^ocid1.servicegateway.", var.oci_network_vcn.existing_service_gw_id)) > 0 ? null : local.validators_msg_map[local.invalid_srv_gw_msg] : null
}
