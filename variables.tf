# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.

#Contains generic variables not pertaining to individual component

variable "tenancy_ocid" {
  type        = string
  description = "tenancy id"
}

variable "region" {
 type        = string
  description = "OCI cluster region"
}

variable "compartment_ocid" {
  type        = string
  description = "compartment id"
}


# ssh keys
variable "ssh_public_key" {
  description = "ssh public key"
}

variable "resource_prefix" {
  type = string
}

# bastion
variable "bastion_shape" {
  description = "shape of bastion instance"
  default     = "VM.Standard.E2.1"
}

variable "admin_shape" {
  description = "shape of admin instance"
  default     = "VM.Standard.E2.1"
}

variable "assign_admin_public_ip" {
  description = "flag to indicate the admin host have public IP"
  default     = false
}

# availability domains-default regional
variable "admin_availability_domain" {
  description = "Availability domain for admin host"
  type        = string
  default     = ""
}

variable "ocir_region" {
  description = "url to ocir"
  default     = ""
}

variable "ocir_custom_image_repo_name" {
  description = "OCIR repository to download existing custom wls image for domain creation"
  default     = ""
}

variable "ocir_user" {
  description = "OCIR user for ocir login"
}

variable "ocir_auth_token_ocid" {
  description = "Secrets OCID for OCIR authorization token"
}

# FSS variables
variable "fss_availability_domain" {
  description = "AD for FSS subnet"
  default     = ""
}

variable "mountTarget_compartment_id" {
  description = "Compartment OCID for the Mount Target"
  type        = string
  default     = ""
}

variable "mountTarget_id" {
  description = "existing mount target id"
  default     = ""
}

variable "private_fss_subnet" {
  description = "Create private or public FSS subnet"
  default     = true
}

# Env variables
variable "mode" {
  description = "flag indicating mode of deployment"
  default     = "PROD"
}

variable "dev_tenancy_proxy" {
  description = "Proxy to be used for OCI development tenancies"
  default     = ""
}

variable "log_level" {
  description = "Indicates logging level for provisioning"
  default     = "INFO"
}

variable "logs_dir" {
  description = "base directory for logs"
  default     = "/u01/logs"
}

variable "node_pool_single_ad" {
  description = "Use single AD for worker nodes in node pool. Only works for DEV mode."
  default     = ""
}


variable "vcn_strategy" {
  description = "Change between creating new VCN or using an existing VCN"
  default     = "Use Existing VCN"
}

variable "use_existing_subnets" {
  description = "Stores the flag to indicate use of existing subnets on UI"
  default     = false
}

variable "db_strategy_new_vcn" {
  description = "DB Strategy"
  default     = "No Database"
}

variable "db_strategy_existing_vcn" {
  description = "DB Strategy"
  default     = "No Database"
}

variable "lb_http_port" {
  description = "Http port for ingress load balancer"
  default     = "80"
}

variable "lb_https_port" {
  description = "Https port for ingress load balancer"
  default     = "443"
}

variable "lb_shape" {
  description = "Https port for ingress load balancer"
  default     = "400Mbps"
}

variable "is_lb_private" {
  description = "Https port for ingress load balancer"
  default     = false
  type        = bool
}

variable "is_clair_scan_enabled" {
  description = "Is clair scan of docker images enabled?"
  default     = false
  type        = bool
}

variable "create_policies" {
  type    = bool
  default = true
}