# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

variable "log_level" {}

#WebLogic validation
variable "wls_version" {}
variable "wls_admin_user" {}
variable "wls_admin_password" {}
variable "wls_domain_name" {}
variable "wls_nm_port" {}
variable "wls_admin_port" {}
variable "wls_admin_node_port" {}
variable "wls_admin_ssl_port" {}
variable "wls_cluster_mc_port" {}
variable "wls_extern_admin_port" {}
variable "wls_extern_ssl_admin_port" {}
variable "wls_ms_port" {}
variable "wls_ms_ssl_port" {}
variable "mode" {}
variable "ocir_password" {}

variable "existing_mount_target_id" {}
variable "mountTarget_vcn_id" {}

# networking parameters
variable "oci_network_vcn" {
  type = object({
    vcn_cidr               = string
    create_nat_gateway     = bool
    nat_gateway_name       = string
    create_service_gateway = bool
    service_gateway_name   = string
    existing_vcn_id        = string
    existing_nat_gw_id     = string
    existing_service_gw_id = string
  })
}

variable "oke_cluster_config" {
  type = object({
    cluster_kubernetes_version = string
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
  })
}

#Oke subnet,gateway parameters
variable "admin_vcn_config" {
  type = object({
    subnet_cidr        = string
    existing_subnet_id = string
  })
}

variable "fss_vcn_config" {
  type = object({
    subnet_cidr         = string
    existing_subnet_id  = string
    availability_domain = string
    private_subnet      = string
  })
}

#Oke subnet,gateway parameters
variable "bastion_vcn_config" {
  type = object({
    subnet_cidr        = string
    existing_subnet_id = string
  })
}

variable "atp_db_config" {
  type = object({
    atp_db_id             = string
    atp_db_level          = string
    atp_db_password       = string
    atp_db_compartment_id = string
  })
}

variable "oci_db_config" {
  type = object({
    ocidb_compartment_id         = string
//    ocidb_network_compartment_id = string
//    ocidb_existing_vcn_id        = string
    ocidb_dbsystem_id            = string
    ocidb_database_id            = string
    ocidb_pdb_service_name       = string
    oci_db_user                  = string
    db_port                      = string
    oci_db_password              = string
  })
}

variable "oke_secret_enc" {
  type = object({
    use_encryption  = bool
    key_ocid        = string
  })
}


variable "lb_resource_availability" {}
