# Copyright  2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

module "vcn" {
  source          = "./vcn"
  oci_network_vcn = local.oci_network_vcn
}

module "oke-vcn-config" {
  source         = "./oke-vcn-config"
  oke_vcn_config = local.oke_vcn_config
  label_prefix   = var.label_prefix
  compartment_id = var.compartment_id
}
module "bastion-vcn-config" {
  source             = "./bastion-vcn-config"
  label_prefix       = var.label_prefix
  bastion_vcn_config = local.bastion_vcn_config
}


module "admin-vcn-config" {
  source           = "./admin-vcn-config"
  label_prefix     = var.label_prefix
  admin_vcn_config = local.admin_vcn_config
}


module "fss-vcn-config" {
  source         = "./fss-vcn-config"
  label_prefix   = var.label_prefix
  compartment_id = var.compartment_id
  fss_vcn_config = local.fss_vcn_config
}

