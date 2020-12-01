# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.
locals {

  validators_msg_map = { #Dummy map to trigger an error in case we detect a validation error.
  }

  #Validate log level
  invalid_log_level     = ! contains(list("DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"), var.log_level)
  invalid_log_level_msg = "WLSOKE-ERROR: The value for log_level=[${var.log_level}] is not valid. The permissible values are [DEBUG, INFO, WARNING, ERROR, CRITICAL]"
  validate_log_level    = local.invalid_log_level ? local.validators_msg_map[local.invalid_log_level_msg] : null
  
  #LoadBalancer
    
  invalid_lb_quantity     = (var.lb_resource_availability < 2 ) 
  insufficient_lb_msg     =  "WLSOKE-ERROR: Insufficient resources for load balancer=[${var.lb_resource_availability}]"
  validate_lb_quantity    = local.invalid_lb_quantity ? local.validators_msg_map[0] : null

  #WebLogic validation
  invalid_wls_version     = ! contains(list("12.2.1.4.0"), var.wls_version)
  invalid_wls_version_msg = "WLSOKE-ERROR: The value for wls_version=[${var.wls_version}] is not valid. The permissible values are [ 12.2.1.4.0 ]."
  validate_wls_version    = local.invalid_wls_version ? local.validators_msg_map[local.invalid_wls_version_msg] : null

  #WLS admin user and password validation
  invalid_wls_admin_user     = replace(var.wls_admin_user, "/^[a-zA-Z][a-zA-Z0-9]{7,127}/", "0")
  invalid_wls_admin_user_msg = "WLSOKE-ERROR: WebLogic Administrator admin user provided should be alphanumeric and length should be between 8 and 128 characters."
  validate_wls_admin_user    = local.invalid_wls_admin_user != "0" ? local.validators_msg_map[local.invalid_wls_admin_user_msg] : null

  #WLS domain name validation
  invalid_wls_domain_name      = replace(var.wls_domain_name, "/^[a-zA-Z][a-zA-Z0-9_-]{0,29}/", "0")
  invalid_wls_domain_name_msg  = "WLSOKE-ERROR: WebLogic domain name provided should be alphanumeric and length should be maximum 30 characters." 
  validate_wls_domain_name     = ( var.wls_domain_name != "" && local.invalid_wls_domain_name != "0") ? local.validators_msg_map[local.invalid_wls_domain_name_msg] : null

  #WLS ports
  invalid_wls_nm_port     = (var.wls_nm_port < 0)
  invalid_wls_nm_port_msg = "WLSOKE-ERROR: The value for wls_nm_port=[${var.wls_nm_port}] is not valid. The value has to be greater than 0."
  validate_wls_nm_port    = local.invalid_wls_nm_port ? local.validators_msg_map[local.invalid_wls_nm_port_msg] : null

  invalid_wls_admin_port     = (var.wls_admin_port < 0)
  invalid_wls_admin_port_msg = "WLSOKE-ERROR: The value for wls_admin_port=[${var.wls_admin_port}] is not valid. The value has to be greater than 0."
  validate_wls_admin_port    = local.invalid_wls_admin_port ? local.validators_msg_map[local.invalid_wls_admin_port_msg] : null

  invalid_wls_admin_node_port     = (var.wls_admin_node_port < 0)
  invalid_wls_admin_node_port_msg = "WLSOKE-ERROR: The value for wls_admin_node_port=[${var.wls_admin_node_port}] is not valid. The value has to be greater than 0."
  validate_wls_admin_node_port    = local.invalid_wls_admin_node_port ? local.validators_msg_map[local.invalid_wls_admin_node_port_msg] : null

  invalid_wls_admin_ssl_port     = (var.wls_admin_ssl_port < 0)
  invalid_wls_admin_ssl_port_msg = "WLSOKE-ERROR: The value for wls_admin_ssl_port=[${var.wls_admin_ssl_port}] is not valid. The value has to be greater than 0."
  validate_wls_admin_ssl_port    = local.invalid_wls_admin_ssl_port ? local.validators_msg_map[local.invalid_wls_admin_ssl_port_msg] : null

  invalid_wls_cluster_mc_port     = (var.wls_cluster_mc_port < 0)
  invalid_wls_cluster_mc_port_msg = "WLSOKE-ERROR: The value for wls_cluster_mc_port=[${var.wls_cluster_mc_port}] is not valid. The value has to be greater than 0."
  validate_wls_cluster_mc_port    = local.invalid_wls_cluster_mc_port ? local.validators_msg_map[local.invalid_wls_cluster_mc_port_msg] : null

  invalid_wls_extern_admin_port     = (var.wls_extern_admin_port < 0)
  invalid_wls_extern_admin_port_msg = "WLSOKE-ERROR: The value for wls_extern_admin_port=[${var.wls_extern_admin_port}] is not valid. The value has to be greater than 0."
  validate_wls_extern_admin_port    = local.invalid_wls_extern_admin_port ? local.validators_msg_map[local.invalid_wls_extern_admin_port_msg] : null

  invalid_wls_extern_ssl_admin_port     = (var.wls_extern_ssl_admin_port < 0)
  invalid_wls_extern_ssl_admin_port_msg = "WLSOKE-ERROR: The value for wls_extern_ssl_admin_port=[${var.wls_extern_ssl_admin_port}] is not valid. The value has to be greater than 0."
  validate_wls_extern_ssl_admin_port    = local.invalid_wls_extern_ssl_admin_port ? local.validators_msg_map[local.invalid_wls_extern_ssl_admin_port_msg] : null

  invalid_wls_ms_port     = (var.wls_ms_port < 0)
  invalid_wls_ms_port_msg = "WLSOKE-ERROR: The value for wls_ms_port=[${var.wls_ms_port}] is not valid. The value has to be greater than 0."
  validate_wls_ms_port    = local.invalid_wls_ms_port ? local.validators_msg_map[local.invalid_wls_ms_port_msg] : null

  invalid_wls_ms_ssl_port     = (var.wls_ms_ssl_port < 0)
  invalid_wls_ms_ssl_port_msg = "WLSOKE-ERROR: The value for wls_ms_ssl_port=[${var.wls_ms_ssl_port}] is not valid. The value has to be greater than 0."
  validate_wls_ms_ssl_port    = local.invalid_wls_ms_ssl_port ? local.validators_msg_map[local.invalid_wls_ms_ssl_port_msg] : null

  #OCID validations
  invalid_wls_admin_password_msg  = "WLSOKE-ERROR: The value for WebLogic Admin Password [wls_admin_password_ocid] is not valid. The value must begin with ocid1 followed by resource type, e.g. ocid1.vaultsecret."
  validate_wls_admin_password      = length(regexall("^ocid1.vaultsecret.", var.wls_admin_password)) > 0 ? null : local.validators_msg_map[local.invalid_wls_admin_password_msg]

  invalid_ocir_password_msg = "WLSOKE-ERROR: The value for OCIR Authorization Token [ocir_auth_token_ocid] is not valid. The value must begin with ocid1 followed by resource type, e.g. ocid1.vaultsecret."
  validate_ocir_password    = length(regexall("^ocid1.vaultsecret.", var.ocir_password)) > 0 ? null : local.validators_msg_map[local.invalid_ocir_password_msg]
}

