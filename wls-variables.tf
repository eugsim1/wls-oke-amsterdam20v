/*
 * Copyright (c) 2019, 2020, Oracle and/or its affiliates. All rights reserved.
 */

/**
* Variables for weblogic configuration in OKE cluster
*/

variable "wls_domain_name" {
  description = "Weblogic domain name"
  type        = string
  default     = ""
}

# Defines the number of managed service to be configured
variable "wls_configured_ms_count" {
  type    = number
  default = 9
}

# Defines the actual number of managed server running
variable "wls_ms_replica_count" {
  type    = number
  default = 2
}


# WLS related input variables
variable "wls_admin_user" {
  description = "Adminstration user for weblogic"
  type        = string
}

variable "wls_admin_password_ocid" {
  description = "Secrets OCID for Adminstration password for weblogic"
  type        = string
}

variable "wls_nm_port" {
  description = "Node manager port"
  type        = number
  default     = 5556
}

variable "wls_admin_port" {
  description = "Administration port"
  type        = number
  default     = 7001
}

variable "wls_admin_node_port" {
  description = "Administration Node port"
  type        = number
  default     = 30701
}

variable "wls_admin_ssl_port" {
  type    = number
  default = 7002
}

variable "wls_cluster_mc_port" {
  type    = number
  default = 5555
}

variable "wls_extern_admin_port" {
  type    = number
  default = 30012
}

variable "wls_extern_ssl_admin_port" {
  type    = number
  default = 30013
}

variable "wls_ms_port" {
  type    = number
  default = 8001
}

variable "wls_ms_ssl_port" {
  type    = number
  default = 8002
}

/**
 * Supported versions:
 * 12cRelease214 - 12.2.1.4.0
 */
variable "wls_version" {
  type    = string
  default = "12.2.1.4.0"
}

variable "deploy_sample_app" {
  type    = bool
  default = false
}

#Variables to be added based WLS version
#to be added as part of the MP build
variable "expose_admin_t3_channel" {
  description = "expose admin t3 channel as service"
  default     = false
}

variable "expose_admin_node_port" {
  description = "expose admin node port"
  default     = false
}

variable "enable_log_home_on_pv" {
  description = "Flag to turn on weblogic logging on persistent volume"
  default     = true
}

variable "cpu_request_per_ms_pod" {
  description = "Value for CPU to be allocated per pod in OKE cluster"
  type        = number
  default     = 0.1
}
