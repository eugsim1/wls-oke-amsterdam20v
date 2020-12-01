# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  ad_name = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name

  # Remove all characters from the resource_prefix that dont satisfy the criteria:
  # must start with letter, must only contain letters and numbers and length between 1,8
  # See https://github.com/google/re2/wiki/Syntax - regex syntax supported by replace()

  #Note: The object storage namespace from datastore. It can be different from tenancy name.
  #Object storage namespace can be found here: https://console.us-phoenix-1.oraclecloud.com/a/tenancy/regions
  ocir_namespace = data.oci_objectstorage_namespace.object_namespace.namespace

  ocir_user = "${format("%s/%s", local.ocir_namespace, var.ocir_user)}"

  #use region if supplied
  home_region     = lookup(data.oci_identity_regions.home-region.regions[0], "name")
  region_keys     = data.oci_identity_regions.all_regions.regions.*.key
  region_names    = data.oci_identity_regions.all_regions.regions.*.name
  ocir_region     = var.ocir_region == "" ? lower(element(local.region_keys, index(local.region_names, lower(var.region)))) : var.ocir_region
  ocir_region_url = "${format("%s.ocir.io", local.ocir_region)}"

  network_compartment_id = var.network_compartment_id == "" ? var.compartment_ocid : var.network_compartment_id
  resource_prefix        = "${replace(var.resource_prefix, "/[^a-z0-9]/", "")}"
  wls_admin_server_name  = "${format("%s-adminserver", local.resource_prefix)}"
  wls_cluster_name       = "${format("%s-cluster", local.resource_prefix)}"
  wls_machine_name       = "${format("%s-machine", local.resource_prefix)}"
  wls_ms_server_name     = "${format("%s-managed-server", local.resource_prefix)}"

  oke_cluster_name = var.cluster_name == "" ? "cluster" : var.cluster_name

  #if domain name is not specified, construct one using the resource prefix
  wls_domain_name = var.wls_domain_name == "" ? ("${format("%s_domain", local.resource_prefix)}") : var.wls_domain_name

  wls_domain_secret        = "${lower(format("%s-weblogic-credentials", local.resource_prefix))}"
  wls_domain_namespace     = "${lower(format("%s-domain-ns", local.resource_prefix))}"
  wls_domain_uid           = "${lower(replace(local.wls_domain_name, "_", ""))}"
  wls_operator_namespace   = "${lower(format("%s-operator-ns", local.resource_prefix))}"
  wls_operator_serviceacct = "${lower(format("%s-operator-sa", local.resource_prefix))}"
  weblogic_operator_name   = "${lower(format("%s-weblogic-operator", local.resource_prefix))}"

  wls_node_pool_shape     = var.wls_node_pool_shape
  wls_node_pool_count     = var.wls_node_pool_count
  non_wls_node_pool_shape = var.non_wls_node_pool_shape
  non_wls_node_pool_count = var.non_wls_node_pool_count

  #use domain name if no path variable is provided
  fss_chart_name    = "${lower(format("%s-oke-fss", local.resource_prefix))}"
  jenkins_namespace = "${lower(format("%s-jenkins-ns", local.resource_prefix))}"

  external_lb_name         = "${format("%s-external", local.resource_prefix)}"
  internal_ingress_lb_name = "${format("%s-internal", local.resource_prefix)}"

  #ocir repos
  domain_repo = "${format("%s/%s/%s/%s/wls-domain-base", local.ocir_region_url, local.ocir_namespace, lower(local.resource_prefix), lower(local.wls_domain_name))}"
  infra_repo  = "${format("%s/%s/%s/%s", local.ocir_region_url, local.ocir_namespace, lower(local.resource_prefix), "infra")}"

  #default values
  ssl_cert_secret_name = "oke-ssl-secret"
  ocir_secret_name     = "ocirsecrets"
  vmscripts_path       = "/u01/zips/wlsoke-vmscripts.zip"

  vm_shared_scripts_path = "/u01/zips/wlsoke-sharedscripts.zip"

  tf_version_file = "version.txt"
  #same mount path for admin and pods
  mount_path              = "/u01/shared"
  oke_wls_logs_home       = "${format("%s/logs", local.mount_path)}"
  oke_wls_data_store_home = "${format("%s/data/store", local.mount_path)}"
  scripts_dir             = "/u01/scripts"
  export_path             = format("/%s", local.resource_prefix)
  #Sample-app values
  sample_app_name         = "sample-app"
  sample_app_archive      = "sample-app.war"
  sample_app_archive_type = "war"

  is_atp = var.atp_db_id != ""

  #set the default values only for new VCN
  bastion_subnet_cidr     = (var.existing_vcn_id != "" && var.existing_bastion_subnet_id == "" && var.bastion_subnet_cidr != "") ? var.bastion_subnet_cidr : "10.0.1.0/28"
  admin_subnet_cidr       = (var.existing_vcn_id != "" && var.existing_admin_subnet_id == "" && var.admin_subnet_cidr != "") ? var.admin_subnet_cidr : "10.0.2.0/28"
  lb_subnet_cidr          = (var.existing_vcn_id != "" && var.existing_lb_subnet_id == "" && var.lb_subnet_cidr != "") ? var.lb_subnet_cidr : "10.0.3.0/28"
  oke_workers_subnet_cidr = (var.existing_vcn_id != "" && var.existing_oke_workers_subnet_id == "" && var.oke_workers_subnet_cidr != "") ? var.oke_workers_subnet_cidr : "10.0.4.0/28"
  fss_subnet_cidr         = (var.existing_vcn_id != "" && var.existing_fss_subnet_id == "" && var.fss_subnet_cidr != "") ? var.fss_subnet_cidr : "10.0.5.0/28"
  mountTarget_vcn_id      = var.mountTarget_id != "" && var.mountTarget_compartment_id != "" ? data.oci_core_subnet.mountTarget_subnet[0].vcn_id : ""

  #enable k8 secret encryption using key in Vault
  vault_key_ocid = var.use_encryption ? var.vault_key_ocid : ""

  #Oracle-Linux-7.7-2019.11.12-0:https://docs.cloud.oracle.com/en-us/iaas/images/image/501c6e22-4dc6-4e99-b045-cae47aae343f/
  node_pool_image_map = {
    ap-mumbai-1     = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa46gx23hrdtxenjyt4p5cc3c4mbvyiqxcb3mmrxnmjn3rfxgvqcma"
    us-phoenix-1    = "ocid1.image.oc1.phx.aaaaaaaauuj2b3bvpbtpcyrfdvxu7tuajrwsmajhn6uhvx4oquecap63jywa"
    us-ashburn-1    = "ocid1.image.oc1.iad.aaaaaaaaox73mjjcopg6damp7tssjccpp5opktr3hwgr63u2lacdt2nver5a"
    eu-frankfurt-1  = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa3bu75jht762mfvwroa2gdck6boqwyktztyu5dfhftcycucyp63ma"
    eu-zurich-1     = "ocid1.image.oc1.eu-zurich-1.aaaaaaaadx6lizhaqdnuabw4m5dvutmh5hkzoih373632egxnitybcripb2a"
    me-jeddah-1     = "ocid1.image.oc1.me-jeddah-1.aaaaaaaat6ec2mtk3nww6sq4k24fgeuaa7yfopsvf4y3gkkfczjvcmsbm6sq"
    sa-saopaulo-1   = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa3ke6hsjwdshzoh4mtjq3m6f7rhv4c4dkfljr53kjppvtiio7nv3q"
    uk-gov-london-1 = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaa45cjcaz2ywhqtcjcxtkqq4z2npe5y2c5647kjxbonrlayj3a5seq"
    eu-amsterdam-1  = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaabqqydhob7fwk2oadyodppfomr5ltsrtf3ebmbkhtohqvb6okjxua"
    uk-london-1     = "ocid1.image.oc1.uk-london-1.aaaaaaaasutdhza5wtsrxa236ewtmfa6ixezlaxwxbw7vti2wyi5oobsgoeq"
    ca-toronto-1    = "ocid1.image.oc1.ca-toronto-1.aaaaaaaagupuj5dfue6gvpmlzzppvwryu4gjatkn2hedocbxbvrtrsmnc5oq"
    us-langley-1    = "ocid1.image.oc2.us-langley-1.aaaaaaaaxyipolnyhfw3t34nparhtlez5cbslyzbvlwxky6ph4mh4s22zmnq"
    us-luke-1       = "ocid1.image.oc2.us-luke-1.aaaaaaaa5dtevrzzxk35dwslew5e6zcqljtfu5hzolcedr467gzuqdg3ls5a"
    ap-seoul-1      = "ocid1.image.oc1.ap-seoul-1.aaaaaaaavwjewurl3nvcyq6bgpbrapk4wfwu6qz2ljlrj2yk3cfqexeq64na"
    ap-sydney-1     = "ocid1.image.oc1.ap-sydney-1.aaaaaaaae5qy5o6s2ve2lt4aetmd7s4ydpupowhs6fdl25w4qpkdidbuva5q"
    ap-tokyo-1      = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaa54xb7m4f42vckxkrmtlpys32quyjfldbkhq5zsbmw2r6v5hzgvkq"
  }

  wls_node_pool_image_id     = var.use_nodepool_marketplace_image ? var.mp_wls_node_pool_image_id : var.wls_node_pool_image_id
  non_wls_node_pool_image_id = var.non_wls_node_pool_image_id


  bastion_mp_subscription = {
    compartment_id              = var.compartment_ocid
    mp_listing_id               = var.mp_bastion_listing_id
    mp_listing_resource_version = var.mp_bastion_listing_resource_version
    use_marketplace_image       = var.use_bastion_marketplace_image
  }

  admin_mp_subscription = {
    compartment_id              = var.compartment_ocid
    mp_listing_id               = var.mp_admin_listing_id
    mp_listing_resource_version = var.mp_admin_listing_resource_version
    use_marketplace_image       = var.use_admin_marketplace_image
  }

  nodepool_mp_subscription = {
    compartment_id              = var.compartment_ocid
    mp_listing_id               = var.mp_wls_node_pool_listing_id
    mp_listing_resource_version = var.mp_wls_node_pool_listing_resource_version
    use_marketplace_image       = var.use_nodepool_marketplace_image
  }

  ##admin RELATED PARAMETERS##
  oci_base_identity = {
    network_compartment_id = local.network_compartment_id
    compartment_id         = var.compartment_ocid
    tenancy_id             = var.tenancy_ocid
    ssh_public_key         = file(var.ssh_public_key)
    opc_ssh_private_key    = module.opc-key.OPCPrivateKey["private_key_pem"]
    opc_ssh_public_key     = module.opc-key.OPCPrivateKey["public_key_openssh"]
    region                 = var.region
    home_region            = local.home_region
  }

  oci_bastion = {
    label_prefix        = local.resource_prefix
    instance_shape      = var.bastion_shape
    availability_domain = local.ad_name ##var.admin_availability_domain
    instance_image_id   = var.bastion_image_id
    subnet_id           = module.network.bastion_subnet_id
  }

  oci_admin = {
    label_prefix        = local.resource_prefix
    admin_shape         = var.admin_shape
    availability_domain = local.ad_name ##var.admin_availability_domain
    image_id            = var.admin_image_id
    subnet_id           = module.network.admin_subnet_id
    assign_public_ip    = var.assign_admin_public_ip
  }

  oke_general = {
    label_prefix = local.resource_prefix
    region       = var.region
  }


  ##NETWORK MODULE PARAMETERS##
  oci_network_vcn = {
    compartment_id         = var.network_compartment_id
    vcn_cidr               = var.vcn_cidr
    create_nat_gateway     = var.create_nat_gateway
    nat_gateway_name       = var.nat_gateway_name
    create_service_gateway = var.create_service_gateway
    service_gateway_name   = var.service_gateway_name
    existing_vcn_id        = var.existing_vcn_id
    existing_nat_gw_id     = var.existing_nat_gw_id
    existing_service_gw_id = var.existing_service_gw_id
  }

  #Oke subnet,gateway parameters
  oke_vcn_config = {
    is_service_gateway_enabled     = var.create_service_gateway
    lb_subnet_cidr                 = local.lb_subnet_cidr
    oke_workers_subnet_cidr        = local.oke_workers_subnet_cidr
    allow_node_port_access         = var.allow_node_port_access
    allow_worker_ssh_access        = var.allow_worker_ssh_access
    worker_mode                    = var.worker_mode
    existing_lb_subnet_id          = var.existing_lb_subnet_id
    existing_oke_workers_subnet_id = var.existing_oke_workers_subnet_id
    private_lb                     = var.ingress_private_lb
  }

  #Oke subnet,gateway parameters
  bastion_vcn_config = {
    subnet_cidr        = local.bastion_subnet_cidr
    existing_subnet_id = var.existing_bastion_subnet_id
  }

  #Oke subnet,gateway parameters
  admin_vcn_config = {
    subnet_cidr        = local.admin_subnet_cidr
    existing_subnet_id = var.existing_admin_subnet_id
    assign_public_ip   = var.assign_admin_public_ip
  }

  #FSS subnet parameters
  fss_vcn_config = {
    subnet_cidr         = local.fss_subnet_cidr
    existing_subnet_id  = var.existing_fss_subnet_id
    availability_domain = var.fss_availability_domain
    private_subnet      = var.private_fss_subnet
  }

  oke_admin = {
    admin_id         = module.admin.admin_id
    admin_public_ip  = module.admin.admin_public_ip
    admin_private_ip = module.admin.admin_private_ip
    use_public_ip    = var.assign_admin_public_ip
    mode             = var.mode
  }

  oke_cluster = {
    cluster_kubernetes_version                              = var.kubernetes_version
    cluster_name                                            = local.oke_cluster_name
    cluster_options_add_ons_is_kubernetes_dashboard_enabled = var.dashboard_enabled
    cluster_options_kubernetes_network_config_pods_cidr     = var.pods_cidr
    cluster_options_kubernetes_network_config_services_cidr = var.services_cidr
    cluster_subnets                                         = module.network.oke_subnet_ids
    vcn_id                                                  = module.network.vcn_id
    use_encryption                                          = var.use_encryption
    vault_key_ocid                                          = local.vault_key_ocid
    existing_cluster_id                                     = var.existing_cluster_id
    use_existing_cluster_id                                 = var.existing_cluster_id != ""
  }

  node_pools = {
    node_pool_name_suffix      = var.node_pool_name_suffix
    wls_node_pool_image_id     = local.wls_node_pool_image_id
    wls_node_pool_shape        = var.wls_node_pool_shape
    wls_node_pool_count        = var.wls_node_pool_count
    non_wls_node_pool_image_id = local.non_wls_node_pool_image_id
    non_wls_node_pool_shape    = var.non_wls_node_pool_shape
    non_wls_node_pool_count    = var.non_wls_node_pool_count
    node_pool_single_ad        = var.node_pool_single_ad
  }

  oke_secret_enc = {
    use_encryption = var.use_encryption
    key_ocid       = local.vault_key_ocid
  }

  oci_metadata_attrs = {
    scripts_dir            = local.scripts_dir
    cpu_request_per_ms_pod = var.cpu_request_per_ms_pod
    wls_admin_server_name  = local.wls_admin_server_name
    wls_ms_server_name     = local.wls_ms_server_name
    wls_domain_name        = local.wls_domain_name
    wls_machine_name       = local.wls_machine_name
    wls_cluster_name       = local.wls_cluster_name

    wls_admin_user            = var.wls_admin_user
    wls_configured_ms_count   = var.wls_configured_ms_count
    wls_ms_replica_count      = var.wls_ms_replica_count
    wls_nm_port               = var.wls_nm_port
    wls_admin_port            = var.wls_admin_port
    wls_admin_ssl_port        = var.wls_admin_ssl_port
    wls_admin_node_port       = var.wls_admin_node_port
    wls_cluster_mc_port       = var.wls_cluster_mc_port
    wls_extern_admin_port     = var.wls_extern_admin_port
    wls_extern_ssl_admin_port = var.wls_extern_ssl_admin_port
    wls_ms_port               = var.wls_ms_port
    wls_ms_ssl_port           = var.wls_ms_ssl_port
    wls_version               = var.wls_version
    deploy_sample_app         = var.deploy_sample_app
    sample_app_name           = local.sample_app_name
    sample_app_archive        = local.sample_app_archive
    sample_app_archive_type   = local.sample_app_archive_type
    mode                      = var.mode
    logs_dir                  = var.logs_dir
    tf_script_version         = file(local.tf_version_file)
    vmscripts_path            = local.vmscripts_path
    vm_shared_scripts_path    = local.vm_shared_scripts_path
    log_level                 = var.log_level
    wls_domain_namespace      = local.wls_domain_namespace
    wls_operator_namespace    = local.wls_operator_namespace
    wls_operator_serviceacct  = local.wls_operator_serviceacct
    expose_admin_t3_channel   = var.expose_admin_t3_channel
    expose_admin_node_port    = var.expose_admin_node_port
    wls_domain_secret         = local.wls_domain_secret
    weblogic_operator_name    = local.weblogic_operator_name
    wls_domain_uid            = local.wls_domain_uid
    wls_edition               = var.wls_edition

    #ocir
    ocir_secret_name = local.ocir_secret_name
    ocir_url         = local.ocir_region_url
    ocir_user        = local.ocir_user
    ocir_namespace   = local.ocir_namespace

    #ocir repos
    ocir_custom_image_repo = var.ocir_custom_image_repo_name
    ocir_domain_repo       = local.domain_repo
    ocir_infra_repo        = local.infra_repo

    #fss
    mount_path              = local.mount_path
    fss_chart_name          = local.fss_chart_name
    oke_mount_path          = local.mount_path
    oke_wls_logs_home       = local.oke_wls_logs_home
    oke_wls_data_store_home = local.oke_wls_data_store_home
    enable_log_home_on_pv   = var.enable_log_home_on_pv
    fss_export_path         = local.export_path

    #jenkins
    jenkins_namespace              = var.jenkins_namespace
    jenkins_replica_count          = var.jenkins_replica_count
    jenkins_pull_secret            = var.jenkins_pull_secret
    jenkins_container_port         = var.jenkins_container_port
    jenkins_service_port           = var.jenkins_service_port
    jenkins_service_nodeport       = var.jenkins_service_nodeport
    jenkins_service_targetport     = var.jenkins_service_targetport
    jenkins_service_jnlpport       = var.jenkins_service_jnlpport
    jenkins_service_jnlpnodeport   = var.jenkins_service_jnlpnodeport
    jenkins_service_jnlptargetport = var.jenkins_service_jnlptargetport
    jenkins_name                   = var.jenkins_name

    fss_id                   = module.fss.fss_id
    lb_shape                 = var.ingress_lb_shape
    private_lb               = var.ingress_private_lb
    lb_service_name          = local.internal_ingress_lb_name
    external_lb_service_name = local.external_lb_name

    #ingress
    ingress_namespace       = var.ingress_namespace
    ingress_lb_service_name = local.internal_ingress_lb_name

    #atp
    atp_db_id    = var.atp_db_id
    atp_db_level = var.atp_db_level

    #ocidb
    ocidb_compartment_id   = var.ocidb_compartment_id
    ocidb_dbsystem_id      = var.ocidb_dbsystem_id
    ocidb_database_id      = var.ocidb_database_id
    ocidb_pdb_service_name = var.ocidb_pdb_service_name
    oci_db_user            = var.oci_db_user
    db_port                = var.db_port

    #dynamic_group_id
    admin_dynamic_group_id = module.policies.admin_dynamic_group_id
    create_policies        = var.create_policies

    jenkins_cert_secret_mount_path = var.jenkins_cert_secret_mount_path
    ssl_cert_secret_name           = local.ssl_cert_secret_name

    # clair scan
    is_clair_scan_enabled = var.is_clair_scan_enabled
    dev_tenancy_proxy     = var.dev_tenancy_proxy
  }


  oke_wls_secrets = {
    wls_admin_user                 = var.wls_admin_user
    wls_admin_password_secret_ocid = var.wls_admin_password_ocid
    ocir_auth_token_secret_ocid    = var.ocir_auth_token_ocid
    db_password_secret_ocid        = var.atp_db_id != "" ? var.atp_db_password_ocid : (var.ocidb_dbsystem_id != "" ? var.oci_db_password_ocid : "")
  }

  oci_fss = {
    compartment_id             = var.compartment_ocid
    availability_domain        = local.ad_name ##var.fss_availability_domain
    vcn_id                     = module.network.vcn_id
    label_prefix               = local.resource_prefix
    export_path                = local.export_path
    mountTarget_id             = var.mountTarget_id
    mountTarget_compartment_id = var.mountTarget_compartment_id == "" ? var.compartment_ocid : var.mountTarget_compartment_id
    subnet_id                  = module.network.fss_subnet_id

    #dependency
    fss_secrets_policy_id = module.policies.oke_policy_id
    bastion_public_ip     = module.bastion.bastion_public_ip
    ssh_private_key       = module.opc-key.OPCPrivateKey["private_key_pem"]
  }

  #fss attributes that need to be passed to admin vm
  fss_attributes = {
    nfs_mount_ip         = module.fss.nfs_mount_ip
    nfs_export_path      = local.export_path
    mount_export_id      = module.fss.mount_export_id
    mount_target_id      = module.fss.mountTarget_id
    availability_domain  = var.fss_availability_domain
    wls_domain_namespace = local.wls_domain_namespace
    ocir_secret_name     = local.ocir_secret_name
    fss_chart_name       = local.fss_chart_name
  }

  jenkins_attributes = {
    weblogic_domain_uid            = local.wls_domain_uid
    weblogic_cluster               = local.wls_cluster_name
    ocir_user                      = local.ocir_user
    ocir_jenkins_repo              = local.infra_repo
    ocir_regions                   = local.region_keys
    ocir_default_region            = local.ocir_region
    jenkins_master_version         = var.jenkins_master_version
    jenkins_pull_secret            = var.jenkins_pull_secret
    jenkins_replica_count          = var.jenkins_replica_count
    jenkins_container_port         = var.jenkins_container_port
    jenkins_service_port           = var.jenkins_service_port
    jenkins_service_nodeport       = var.jenkins_service_nodeport
    jenkins_service_targetport     = var.jenkins_service_targetport
    jenkins_service_jnlpport       = var.jenkins_service_jnlpport
    jenkins_service_jnlpnodeport   = var.jenkins_service_jnlpnodeport
    jenkins_service_jnlptargetport = var.jenkins_service_jnlptargetport
    jenkins_name                   = var.jenkins_name
    oke_mount_path                 = local.mount_path
    jenkins_namespace              = var.jenkins_namespace
    kube_url                       = var.kube_url
    jenkins_home                   = var.jenkins_home
    jenkins_host_volume_mount_path = var.jenkins_host_volume_mount_path
    jenkins_proxy                  = var.jenkins_proxy
    jenkins_servicename            = var.jenkins_servicename
    jenkins_oke_mount_path         = local.export_path
    jenkins_cert_secret            = local.ssl_cert_secret_name
    jenkins_cert_secret_mount_path = var.jenkins_cert_secret_mount_path

  }

  ingress_attributes = {
    ocir_ingress_image        = local.infra_repo
    admin-service             = "${format("%s-%s", local.wls_domain_uid, local.wls_admin_server_name)}"
    admin-service-port        = var.wls_admin_port
    cluster-service           = "${format("%s-cluster-%s", local.wls_domain_uid, local.wls_cluster_name)}"
    cluster-service-port      = var.wls_ms_port
    jenkins-service           = var.jenkins_servicename
    jenkins-service-port      = var.jenkins_service_port
    ingress_ocir_secret_name  = local.ocir_secret_name
    ingress_lb_service_name   = local.internal_ingress_lb_name
    ingress_lb_shape          = var.ingress_lb_shape
    ingress_enable_http_port  = var.ingress_enable_http_port
    ingress_enable_https_port = var.ingress_enable_https_port
    ingress_http_port         = var.ingress_http_port
    ingress_https_port        = var.ingress_https_port
    ingress_namespace         = var.ingress_namespace
    jenkins_namespace         = var.jenkins_namespace
    wls-domain_namespace      = local.wls_domain_namespace
    cert_secret_name          = local.ssl_cert_secret_name
    lb_name                   = local.external_lb_name
    lb_namespace              = local.wls_domain_namespace
    shape                     = var.lb_shape
    is_internal               = var.is_lb_private
    https_port                = var.lb_https_port
  }

  atp_attributes = {
    atp_db_id             = var.atp_db_id
    atp_db_level          = var.atp_db_level
    atp_db_password       = var.atp_db_password_ocid
    atp_db_compartment_id = var.atp_db_compartment_id
  }

  ocidb_attributes = {
    ocidb_compartment_id = var.ocidb_compartment_id
    //    ocidb_network_compartment_id = var.ocidb_network_compartment_id == "" ? var.ocidb_compartment_id : var.ocidb_network_compartment_id
    //    ocidb_existing_vcn_id        = var.ocidb_existing_vcn_id
    ocidb_dbsystem_id      = var.ocidb_dbsystem_id
    ocidb_database_id      = var.ocidb_database_id
    ocidb_pdb_service_name = var.ocidb_pdb_service_name
    oci_db_user            = var.oci_db_user
    db_port                = var.db_port
    oci_db_password        = var.oci_db_password_ocid
  }
}
