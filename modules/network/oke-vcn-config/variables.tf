# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

# Identity and access parameters
variable "compartment_id" {}
variable "label_prefix" {}

# networking parameters
variable "oke_vcn_config" {
  type = object({
    ig_route_id                    = string
    is_service_gateway_enabled     = bool
    nat_route_id                   = string
    lb_subnet_cidr                 = string
    oke_workers_subnet_cidr        = string
    bastion_subnet_cidr            = string
    admin_subnet_cidr              = string
    vcn_cidr                       = string
    vcn_id                         = string
    allow_node_port_access         = bool
    allow_worker_ssh_access        = bool
    worker_mode                    = string
    existing_lb_subnet_id          = string
    existing_oke_workers_subnet_id = string
    private_lb                     = bool
  })
}
