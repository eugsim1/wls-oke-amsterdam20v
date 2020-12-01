# Copyright  2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {


  has_existing_subnets = (var.fss_vcn_config.existing_subnet_id!="" || var.oke_vcn_config.existing_lb_subnet_id!="" || var.oke_vcn_config.existing_oke_workers_subnet_id!="" || var.admin_vcn_config.existing_subnet_id!="")

  oci_network_vcn = {
    label_prefix                  = var.label_prefix
    compartment_id                = var.compartment_id
    create_nat_gateway            = var.oci_network_vcn.create_nat_gateway
    nat_gateway_name              = var.oci_network_vcn.nat_gateway_name
    create_service_gateway        = var.oci_network_vcn.create_service_gateway
    service_gateway_name          = var.oci_network_vcn.service_gateway_name
    vcn_cidr                      = var.oci_network_vcn.vcn_cidr
    existing_vcn_id               = var.oci_network_vcn.existing_vcn_id
    existing_nat_gw_id            = var.oci_network_vcn.existing_nat_gw_id
    existing_service_gw_id        = var.oci_network_vcn.existing_service_gw_id
    has_existing_subnets          = local.has_existing_subnets
  }

  oke_vcn_config = {
    ig_route_id                    = module.vcn.ig_route_id
    is_service_gateway_enabled     = var.oci_network_vcn.create_service_gateway
    nat_route_id                   = module.vcn.nat_route_id
    lb_subnet_cidr                 = var.oke_vcn_config.lb_subnet_cidr
    oke_workers_subnet_cidr        = var.oke_vcn_config.oke_workers_subnet_cidr
    bastion_subnet_cidr            = var.bastion_vcn_config.subnet_cidr
    admin_subnet_cidr              = var.admin_vcn_config.subnet_cidr
    vcn_cidr                       = var.oci_network_vcn.vcn_cidr
    vcn_id                         = module.vcn.vcn_id
    allow_node_port_access         = var.oke_vcn_config.allow_node_port_access
    allow_worker_ssh_access        = var.oke_vcn_config.allow_worker_ssh_access
    worker_mode                    = var.oke_vcn_config.worker_mode
    existing_lb_subnet_id          = var.oke_vcn_config.existing_lb_subnet_id
    existing_oke_workers_subnet_id = var.oke_vcn_config.existing_oke_workers_subnet_id
    private_lb                     = var.oke_vcn_config.private_lb
  }

  bastion_vcn_config = {
    compartment_id     = var.compartment_id
    subnet_cidr        = var.bastion_vcn_config.subnet_cidr
    ig_route_id        = module.vcn.ig_route_id
    vcn_id             = module.vcn.vcn_id
    existing_subnet_id = var.bastion_vcn_config.existing_subnet_id
  }

  admin_vcn_config = {
    compartment_id     = var.compartment_id
    subnet_cidr        = var.admin_vcn_config.subnet_cidr
    ig_route_id        = module.vcn.ig_route_id
    nat_route_id       = module.vcn.nat_route_id
    vcn_id             = module.vcn.vcn_id
    existing_subnet_id = var.admin_vcn_config.existing_subnet_id
    #allow access only from bastion subnet
    admin_access_cidr  = module.bastion-vcn-config.subnet_cidr
    assign_public_ip   = var.admin_vcn_config.assign_public_ip
  }

  fss_vcn_config = {
    existing_fss_subnet_id = var.fss_vcn_config.existing_subnet_id
    fss_subnet_cidr        = var.fss_vcn_config.subnet_cidr
    ig_route_id            = module.vcn.ig_route_id
    vcn_id                 = module.vcn.vcn_id
    availability_domain    = var.fss_vcn_config.availability_domain
    private_subnet         = var.fss_vcn_config.private_subnet
  }
}
