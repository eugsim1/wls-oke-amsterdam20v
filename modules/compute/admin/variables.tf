# Copyright  2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

# general
variable "oci_identity" {
  type = object({
    network_compartment_id = string
    compartment_id         = string
    tenancy_id             = string
    ssh_public_key         = string
    opc_ssh_private_key    = string
    opc_ssh_public_key     = string
    region                 = string
    home_region            = string
  })
}

variable "oci_admin" {
  type = object({
    label_prefix        = string
    admin_shape         = string
    availability_domain = string
    image_id            = string
    subnet_id           = string
    assign_public_ip    = bool
  })
}

variable "wls_version_to_rcu_component_list_map" {
  type = map

  default = {
    "12.2.1.4.0" = "MDS,WLS,STB,IAU_APPEND,IAU_VIEWER,UCSUMS,IAU,OPSS"
  }
}

variable "oci_wls_secrets" {
  type = object({
    wls_admin_user                 = string
    wls_admin_password_secret_ocid = string
    db_password_secret_ocid        = string
    ocir_auth_token_secret_ocid    = string
  })
}


variable "oci_metadata_attrs" {
  type = object({
    scripts_dir               = string
    cpu_request_per_ms_pod    = string
    wls_admin_server_name     = string
    wls_ms_server_name        = string
    wls_domain_name           = string
    wls_machine_name          = string
    wls_cluster_name          = string
    wls_admin_user            = string
    wls_configured_ms_count   = number
    wls_ms_replica_count      = number
    wls_nm_port               = number
    wls_admin_port            = number
    wls_admin_ssl_port        = number
    wls_admin_node_port       = number
    wls_cluster_mc_port       = number
    wls_extern_admin_port     = number
    wls_extern_ssl_admin_port = number
    wls_ms_port               = number
    wls_ms_ssl_port           = number
    wls_version               = string
    deploy_sample_app         = bool
    sample_app_name           = string
    sample_app_archive        = string
    sample_app_archive_type   = string
    mode                      = string
    dev_tenancy_proxy         = string
    logs_dir                  = string
    ocir_secret_name          = string
    vmscripts_path            = string
    vm_shared_scripts_path    = string
    log_level                 = string
    tf_script_version         = string
    wls_domain_namespace      = string
    wls_operator_namespace    = string
    wls_operator_serviceacct  = string
    expose_admin_t3_channel   = string
    expose_admin_node_port    = string
    wls_domain_secret         = string
    weblogic_operator_name    = string
    wls_domain_uid            = string
    wls_edition               = string

    ocir_user      = string
    ocir_url       = string
    ocir_namespace = string

    #ocir repos
    ocir_custom_image_repo = string
    ocir_domain_repo       = string
    ocir_infra_repo        = string

    mount_path              = string
    fss_chart_name          = string
    oke_mount_path          = string
    oke_wls_logs_home       = string
    oke_wls_data_store_home = string
    enable_log_home_on_pv   = bool
    fss_export_path         = string

    #jenkins
    jenkins_namespace              = string
    jenkins_replica_count          = string
    jenkins_pull_secret            = string
    jenkins_container_port         = string
    jenkins_service_port           = string
    jenkins_service_nodeport       = string
    jenkins_service_targetport     = string
    jenkins_service_jnlpport       = string
    jenkins_service_jnlpnodeport   = string
    jenkins_service_jnlptargetport = string
    jenkins_name                   = string
    jenkins_cert_secret_mount_path = string
    fss_id                         = string
    lb_shape                       = string
    private_lb                     = bool
    lb_service_name                = string

    #ingress
    ingress_namespace        = string
    ingress_lb_service_name  = string
    external_lb_service_name = string

    #atp
    atp_db_id    = string
    atp_db_level = string

    #ocidb
    ocidb_compartment_id   = string
    ocidb_dbsystem_id      = string
    ocidb_database_id      = string
    ocidb_pdb_service_name = string
    oci_db_user            = string
    db_port                = string

    #dynamic group id
    admin_dynamic_group_id   = string
    create_policies          = bool

    ssl_cert_secret_name = string

    #clair scan
    is_clair_scan_enabled = bool
  })
}
