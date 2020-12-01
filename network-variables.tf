# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

#file to capture vcn, subnet and gateway parameters
variable "network_compartment_id" {
  type        = string
  default     = ""
  description = "Network compartment id"
}

#** EXISTING NETWORK IDs **#
variable "existing_vcn_id" {
  type        = string
  default     = ""
  description = "Existing VCN ID"
}

variable "existing_lb_subnet_id" {
  type        = string
  default     = ""
  description = "Existing LB subnet ID"
}

variable "existing_oke_workers_subnet_id" {
  type        = string
  default     = ""
  description = "Existing worker nodes subnet ID"
}

variable "existing_bastion_subnet_id" {
  type        = string
  default     = ""
  description = "Existing bastion subnet ID"
}

variable "existing_admin_subnet_id" {
  type        = string
  default     = ""
  description = "Existing admin subnet ID"
}

variable "existing_fss_subnet_id" {
  type        = string
  default     = ""
  description = "Existing FSS subnet ID"
}

variable "existing_nat_gw_id" {
  type        = string
  default     = ""
  description = "Existing nat gateway id"
}

variable "existing_service_gw_id" {
  type        = string
  default     = ""
  description = "Existing service gateway id"
}


#10.0.0.0- 10.0.255.255=>65536
variable "vcn_cidr" {
  type        = string
  description = "cidr block of VCN"
  default     = "10.0.0.0/16"
}

variable "lb_subnet_cidr" {
  default = ""
}

variable "oke_workers_subnet_cidr" {
  default = ""
}

variable "bastion_subnet_cidr" {
  default = ""
}

variable "admin_subnet_cidr" {
  default = ""
}

variable "fss_subnet_cidr" {
  default = ""
}



#**GATEWAY variables**#

# nat
variable "create_nat_gateway" {
  description = "whether to create a nat gateway"
  default     = true
}

variable "nat_gateway_name" {
  description = "display name of the nat gateway"
  default     = "nat-gateway"
}

# service gateway
variable "create_service_gateway" {
  description = "whether to create a service gateway"
  default     = true
}

variable "service_gateway_name" {
  description = "name of service gateway"
  default     = "service-gateway"
}


# security rules -oke
variable "allow_node_port_access" {
  description = "whether to allow access to NodePorts when worker nodes outside access (only applicable for public worker nodes)"
  default     = false
}

variable "allow_worker_ssh_access" {
  description = "whether to allow ssh access to worker nodes when worker nodes from instances in the same VCN"
  default     = true
}