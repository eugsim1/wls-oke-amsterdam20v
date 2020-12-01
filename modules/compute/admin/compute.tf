# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_core_instance" "admin" {
    lifecycle {
        ignore_changes = [ "freeform_tags" , "defined_tags",  ]
    }
	
  availability_domain = var.oci_admin.availability_domain
  compartment_id      = var.oci_identity.compartment_id

  create_vnic_details {
    subnet_id        = var.oci_admin.subnet_id
    display_name     = "${var.oci_admin.label_prefix}-admin-vnic"
    hostname_label   = "${var.oci_admin.label_prefix}-admin"
    assign_public_ip = var.oci_admin.assign_public_ip
  }

  display_name = "${var.oci_admin.label_prefix}-admin"

  extended_metadata = {
    ssh_authorized_keys = var.oci_identity.ssh_public_key
    user_data           = data.template_cloudinit_config.admin.rendered

    home_region             = var.oci_identity.home_region
    #wls
    wls_ms_replica_count    = var.oci_metadata_attrs.wls_ms_replica_count
    wls_admin_server_name   = var.oci_metadata_attrs.wls_admin_server_name
    wls_ms_server_name      = var.oci_metadata_attrs.wls_ms_server_name
    wls_domain_name         = var.oci_metadata_attrs.wls_domain_name
    wls_machine_name        = var.oci_metadata_attrs.wls_machine_name
    wls_cluster_name        = var.oci_metadata_attrs.wls_cluster_name
    wls_admin_user          = var.oci_metadata_attrs.wls_admin_user
    wls_admin_password      = var.oci_wls_secrets.wls_admin_password_secret_ocid
    wls_configured_ms_count = var.oci_metadata_attrs.wls_configured_ms_count
    wls_nm_port             = var.oci_metadata_attrs.wls_nm_port
    wls_admin_port          = var.oci_metadata_attrs.wls_admin_port
    wls_admin_ssl_port      = var.oci_metadata_attrs.wls_admin_ssl_port
    wls_admin_node_port     = var.oci_metadata_attrs.wls_admin_node_port

    wls_cluster_mc_port        = var.oci_metadata_attrs.wls_cluster_mc_port
    wls_ext_admin_port         = var.oci_metadata_attrs.wls_extern_admin_port
    wls_secured_ext_admin_port = var.oci_metadata_attrs.wls_extern_ssl_admin_port
    wls_ms_port                = var.oci_metadata_attrs.wls_ms_port
    wls_ms_ssl_port            = var.oci_metadata_attrs.wls_ms_port
    wls_version                = var.oci_metadata_attrs.wls_version
    deploy_sample_app          = var.oci_metadata_attrs.deploy_sample_app
    sample_app_name            = var.oci_metadata_attrs.sample_app_name
    sample_app_archive         = var.oci_metadata_attrs.sample_app_archive
    sample_app_archive_type    = var.oci_metadata_attrs.sample_app_archive_type

    mode                  = var.oci_metadata_attrs.mode
    dev_tenancy_proxy     = var.oci_metadata_attrs.dev_tenancy_proxy
    is_clair_scan_enabled = var.oci_metadata_attrs.is_clair_scan_enabled

    #ocir
    ocir_url               = var.oci_metadata_attrs.ocir_url
    ocir_user              = var.oci_metadata_attrs.ocir_user
    ocir_namespace         = var.oci_metadata_attrs.ocir_namespace
    ocir_custom_image_repo = var.oci_metadata_attrs.ocir_custom_image_repo
    ocir_domain_repo       = var.oci_metadata_attrs.ocir_domain_repo
    ocir_infra_repo        = var.oci_metadata_attrs.ocir_infra_repo

    ocir_secret_name = var.oci_metadata_attrs.ocir_secret_name
    ocir_password    = var.oci_wls_secrets.ocir_auth_token_secret_ocid
    logs_dir         = var.oci_metadata_attrs.logs_dir
    vmscripts_path   = var.oci_metadata_attrs.vmscripts_path

    vm_shared_scripts_path = var.oci_metadata_attrs.vm_shared_scripts_path

    wls_domain_secret        = var.oci_metadata_attrs.wls_domain_secret
    log_level                = var.oci_metadata_attrs.log_level
    tf_script_version        = var.oci_metadata_attrs.tf_script_version
    wls_domain_namespace     = var.oci_metadata_attrs.wls_domain_namespace
    wls_operator_namespace   = var.oci_metadata_attrs.wls_operator_namespace
    wls_operator_serviceacct = var.oci_metadata_attrs.wls_operator_serviceacct
    weblogic_operator_name   = var.oci_metadata_attrs.weblogic_operator_name

    mount_path              = var.oci_metadata_attrs.mount_path
    fss_chart_name          = var.oci_metadata_attrs.fss_chart_name
    oke_wls_logs_home       = var.oci_metadata_attrs.oke_wls_logs_home
    oke_wls_data_store_home = var.oci_metadata_attrs.oke_wls_data_store_home
    enable_log_home_on_pv   = var.oci_metadata_attrs.enable_log_home_on_pv
    fss_export_path         = var.oci_metadata_attrs.fss_export_path
    wls_domain_uid          = var.oci_metadata_attrs.wls_domain_uid
    wls_edition             = var.oci_metadata_attrs.wls_edition

    expose_admin_t3_channel = var.oci_metadata_attrs.expose_admin_t3_channel
    expose_admin_node_port  = var.oci_metadata_attrs.expose_admin_node_port

    #lb
    lb_shape = var.oci_metadata_attrs.lb_shape
    lb_type  = var.oci_metadata_attrs.private_lb

    #jenkins
    jenkins_namespace              = var.oci_metadata_attrs.jenkins_namespace
    jenkins_replica_count          = var.oci_metadata_attrs.jenkins_replica_count
    jenkins_pull_secret            = var.oci_metadata_attrs.jenkins_pull_secret
    jenkins_container_port         = var.oci_metadata_attrs.jenkins_container_port
    jenkins_service_port           = var.oci_metadata_attrs.jenkins_service_port
    jenkins_service_nodeport       = var.oci_metadata_attrs.jenkins_service_nodeport
    jenkins_service_targetport     = var.oci_metadata_attrs.jenkins_service_targetport
    jenkins_service_jnlpport       = var.oci_metadata_attrs.jenkins_service_jnlpport
    jenkins_service_jnlpnodeport   = var.oci_metadata_attrs.jenkins_service_jnlpnodeport
    jenkins_service_jnlptargetport = var.oci_metadata_attrs.jenkins_service_jnlptargetport
    jenkins_name                   = var.oci_metadata_attrs.jenkins_name
    jenkins_oke_mount_path         = var.oci_metadata_attrs.mount_path

    lb_service_name                = var.oci_metadata_attrs.lb_service_name
    external_lb_service_name       = var.oci_metadata_attrs.external_lb_service_name
    ssl_cert_secret_name           = var.oci_metadata_attrs.ssl_cert_secret_name
    jenkins_cert_secret_mount_path = var.oci_metadata_attrs.jenkins_cert_secret_mount_path

    #ingress
    ingress_namespace       = var.oci_metadata_attrs.ingress_namespace
    ingress_lb_service_name = var.oci_metadata_attrs.ingress_lb_service_name

    #dynamic group id
    admin_dynamic_group_id   = var.oci_metadata_attrs.admin_dynamic_group_id
    create_policies          = var.oci_metadata_attrs.create_policies

    #scripts dir
    scripts_dir            = var.oci_metadata_attrs.scripts_dir
    cpu_request_per_ms_pod = var.oci_metadata_attrs.cpu_request_per_ms_pod

    #atp
    atp_db_id          = var.oci_metadata_attrs.atp_db_id
    atp_db_level       = var.oci_metadata_attrs.atp_db_level
    atp_db_name        = trimspace(var.oci_metadata_attrs.atp_db_id) != "" ? data.oci_database_autonomous_database.atp_db[0].db_name : ""
    rcu_component_list = var.wls_version_to_rcu_component_list_map[var.oci_metadata_attrs.wls_version]
    is_atp_db          = trimspace(var.oci_metadata_attrs.atp_db_id) != ""
    # Whether to provision JRF or non-JRF domain
    is_apply_jrf = local.is_apply_JRF

    # DB password OCID
    db_password = var.oci_wls_secrets.db_password_secret_ocid
    # ATP DB params
    atp_db_id          = var.oci_metadata_attrs.atp_db_id
    atp_db_level       = var.oci_metadata_attrs.atp_db_level
    atp_db_name        = local.is_atp_db ? data.oci_database_autonomous_database.atp_db[0].db_name : ""
    rcu_component_list = var.wls_version_to_rcu_component_list_map[var.oci_metadata_attrs.wls_version]
    is_atp_db          = local.is_atp_db

    # OCI DB params
    db_is_oci_db = local.is_oci_db

    db_hostname_prefix    = local.is_oci_db ? lookup(data.oci_database_db_systems.ocidb_db_systems[0].db_systems[0], "hostname") : ""
    db_host_domain        = local.is_oci_db ? lookup(data.oci_database_db_systems.ocidb_db_systems[0].db_systems[0], "domain") : ""
    db_shape              = local.is_oci_db ? lookup(data.oci_database_db_systems.ocidb_db_systems[0].db_systems[0], "shape") : ""
    db_version            = local.is_oci_db ? data.oci_database_db_home.ocidb_db_home[0].db_version : ""
    db_name               = local.is_oci_db ? data.oci_database_database.ocidb_database[0].db_name : ""
    db_unique_name        = local.is_oci_db ? data.oci_database_database.ocidb_database[0].db_unique_name : ""
    pdb_name              = var.oci_metadata_attrs.ocidb_pdb_service_name
    db_node_count         = local.is_oci_db ? lookup(data.oci_database_db_systems.ocidb_db_systems[0].db_systems[0], "node_count") : ""
    db_user               = local.is_oci_db ? var.oci_metadata_attrs.oci_db_user : (local.is_atp_db ? "ADMIN" : "")
    db_port               = var.oci_metadata_attrs.db_port
    db_storage_management = local.is_oci_db ? lookup(lookup(data.oci_database_db_systems.ocidb_db_systems[0].db_systems[0], "db_system_options")[0], "storage_management") : ""
  }

  shape = var.oci_admin.admin_shape

  source_details {
    source_type = "image"
    source_id   = var.oci_admin.image_id
  }

  timeouts {
    create = "60m"
  }
}