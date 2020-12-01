# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

module "validators" {
  depends_on = [local.ad_name]
  source     = "./modules/validators"

  log_level      = var.log_level
  oke_secret_enc = local.oke_secret_enc
  
  lb_resource_availability = data.oci_limits_resource_availability.lb_resource_availability.available

  #WebLogic parameters
  wls_version               = var.wls_version
  wls_admin_user            = var.wls_admin_user
  wls_admin_password        = var.wls_admin_password_ocid
  wls_domain_name           = var.wls_domain_name
  wls_nm_port               = var.wls_nm_port
  wls_admin_port            = var.wls_admin_port
  wls_admin_node_port       = var.wls_admin_node_port
  wls_admin_ssl_port        = var.wls_admin_ssl_port
  wls_cluster_mc_port       = var.wls_cluster_mc_port
  wls_extern_admin_port     = var.wls_extern_admin_port
  wls_extern_ssl_admin_port = var.wls_extern_ssl_admin_port
  wls_ms_port               = var.wls_ms_port
  wls_ms_ssl_port           = var.wls_ms_ssl_port
  existing_mount_target_id  = var.mountTarget_id
  ocir_password             = var.ocir_auth_token_ocid
  mountTarget_vcn_id        = local.mountTarget_vcn_id
  oci_network_vcn           = local.oci_network_vcn
  oke_vcn_config            = local.oke_vcn_config
  admin_vcn_config          = local.admin_vcn_config
  mode                      = var.mode
  fss_vcn_config            = local.fss_vcn_config
  bastion_vcn_config        = local.bastion_vcn_config
  atp_db_config             = local.atp_attributes
  oci_db_config             = local.ocidb_attributes
  oke_cluster_config        = local.oke_cluster
}

# Generate the opc key for provisioning purposes
module "opc-key" {
  depends_on = [local.ad_name]
  source     = "./modules/opc-key"
}

# Create marketplace subscription for PIC image
module "mp_subscription" {
  depends_on               = [local.ad_name]
  source                   = "./modules/mp-subscription"
  bastion_mp_subscription  = local.bastion_mp_subscription
  admin_mp_subscription    = local.admin_mp_subscription
  nodepool_mp_subscription = local.nodepool_mp_subscription
}

# 1. Creates network
module "network" {
  depends_on = [local.ad_name, module.opc-key]
  source     = "./modules/network"

  # general parameters
  compartment_id = local.network_compartment_id

  label_prefix = local.resource_prefix

  # oke worker network parameters
  oci_network_vcn = local.oci_network_vcn

  oke_vcn_config = local.oke_vcn_config

  bastion_vcn_config = local.bastion_vcn_config

  admin_vcn_config = local.admin_vcn_config

  fss_vcn_config = local.fss_vcn_config
}

#2. Create a bastion host
module "bastion" {
  depends_on = [module.network]
  source     = "./modules/compute/bastion"

  # identity
  oci_identity = local.oci_base_identity

  # general oci parameters
  oci_bastion = local.oci_bastion
}

#2. Create a admin host
module "admin" {
  depends_on = [module.bastion]
  source     = "./modules/compute/admin"

  # identity
  oci_identity = local.oci_base_identity

  # general oci parameters
  oci_admin = local.oci_admin

  # admin parameters
  oci_metadata_attrs = local.oci_metadata_attrs
  oci_wls_secrets    = local.oke_wls_secrets
}

#Create fss for WLS logs and store metadata eg domain yaml for LCM operations
module "fss" {
  source = "./modules/fss"

  oci_fss = local.oci_fss
}

#1. Setup policies for secrets and service principal access
module "policies" {
  source = "./modules/policies"

  # identity
  oci_identity = local.oci_base_identity

  label_prefix       = var.resource_prefix
  is_atp             = local.is_atp
  create_policies    = var.create_policies
  oci_wls_secrets    = local.oke_wls_secrets
  atp_compartment_id = var.atp_db_compartment_id
  providers = {
    oci = oci.home
  }
  oke_secret_enc = local.oke_secret_enc
}

# cluster creation for oke
module "cluster" {
  #   depends_on = [module.admin]
  source = "./modules/oke/cluster"

  # identity
  oke_identity = local.oci_base_identity

  # oci parameters
  oke_general = local.oke_general

  # oke cluster parameters
  oke_cluster = local.oke_cluster

  mode               = var.mode
  weblogic_image_tag = local.domain_repo
}

# nodepool creation for oke
module "nodepool" {
  # depends_on = [module.cluster]
  source = "./modules/oke/nodepool"

  # identity
  oke_identity = local.oci_base_identity

  # oci parameters
  oke_general = local.oke_general

  # oke cluster parameters
  oke_cluster = local.oke_cluster

  # oke node pool parameters
  node_pools         = local.node_pools
  mode               = var.mode
  weblogic_image_tag = local.domain_repo
  cluster_info       = module.cluster.cluster_info
}



# module peforms remote execution on admin for scripts and file transfers
module "provisioner" {
  source = "./modules/provisioner"

  oke_cluster_id     = module.cluster.cluster_id
  oci_identity       = local.oci_base_identity
  oci_admin          = local.oke_admin
  oci_wls_secrets    = local.oke_wls_secrets
  fss_attributes     = local.fss_attributes
  jenkins_attributes = local.jenkins_attributes
  bastion_ip         = module.bastion.bastion_public_ip
  ingress_attributes = local.ingress_attributes

  fss_id = module.fss.fss_id

  atp_attributes = local.atp_attributes
}
