# Copyright  2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

variable "label_prefix" {
  type        = string
  description = "Prefix used for all the network resources"
}

variable "compartment_id" {
  type        = string
  description = "compartment for vcn"

}

# networking parameters
variable "oci_network_vcn" {
  type = object({
    vcn_cidr                      = string
    create_nat_gateway            = bool
    nat_gateway_name              = string
    create_service_gateway        = bool
    service_gateway_name          = string
    existing_vcn_id               = string
    existing_nat_gw_id            = string
    existing_service_gw_id        = string
  })
}

#Oke subnet,gateway parameters
variable "oke_vcn_config" {
  type = object({
    is_service_gateway_enabled     = bool
    lb_subnet_cidr                 = string
    oke_workers_subnet_cidr        = string
    allow_node_port_access         = bool
    allow_worker_ssh_access        = bool
    worker_mode                    = string
    existing_lb_subnet_id          = string
    existing_oke_workers_subnet_id = string
    private_lb                     = bool
  })
}

#Oke subnet,gateway parameters
variable "bastion_vcn_config" {
  type = object({
    subnet_cidr        = string
    existing_subnet_id = string
  })
}

#Oke subnet,gateway parameters
variable "admin_vcn_config" {
  type = object({
    subnet_cidr        = string
    existing_subnet_id = string
    assign_public_ip   = string
  })
}

#Oke subnet,gateway parameters
variable "fss_vcn_config" {
  type = object({
    subnet_cidr        = string
    existing_subnet_id = string
    availability_domain= string
    private_subnet     = bool
  })
}




