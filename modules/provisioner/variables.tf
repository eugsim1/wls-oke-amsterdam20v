# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

variable "oci_identity" {
  type = object({
    network_compartment_id = string
    compartment_id         = string
    tenancy_id             = string
    ssh_public_key         = string
    opc_ssh_private_key    = string
    opc_ssh_public_key     = string
    region                 = string
  })
}

# bastion
variable "bastion_ip" {
  type = string
}

# admin
variable "oci_admin" {
  type = object({
    admin_id         = string
    admin_public_ip  = string
    admin_private_ip = string
    use_public_ip    = bool
    mode             = string
  })
}

variable "oci_wls_secrets" {
  type = object({
    wls_admin_user                 = string
    wls_admin_password_secret_ocid = string
    db_password_secret_ocid        = string
    ocir_auth_token_secret_ocid    = string
  })
}

variable "fss_attributes" {
  type = object({
    nfs_mount_ip         = string
    nfs_export_path      = string
    mount_export_id      = string
    mount_target_id      = string
    availability_domain  = string
    wls_domain_namespace = string
    ocir_secret_name     = string
    fss_chart_name       = string
  })
}

variable "jenkins_attributes" {
  type = object({
    weblogic_domain_uid            = string
    weblogic_cluster               = string
    ocir_user                      = string
    ocir_jenkins_repo              = string
    jenkins_master_version         = string
    jenkins_pull_secret            = string
    jenkins_replica_count          = string
    jenkins_container_port         = string
    jenkins_service_port           = string
    jenkins_service_nodeport       = string
    jenkins_service_targetport     = string
    jenkins_service_jnlpport       = string
    jenkins_service_jnlpnodeport   = string
    jenkins_service_jnlptargetport = string
    jenkins_name                   = string
    jenkins_namespace              = string
    jenkins_proxy                  = string
    kube_url                       = string
    jenkins_home                   = string
    jenkins_host_volume_mount_path = string
    jenkins_servicename            = string
    oke_mount_path                 = string
    jenkins_cert_secret_mount_path = string
    jenkins_cert_secret            = string
    ocir_regions                   = list(string)
    ocir_default_region            = string
  })
}

variable "ingress_attributes" {
  type = object({
    admin-service                    = string
    admin-service-port               = string
    cluster-service                  = string
    cluster-service-port             = string
    jenkins-service                  = string
    jenkins-service-port             = string
    ocir_ingress_image               = string
    ingress_namespace                = string
    ingress_ocir_secret_name         = string
    ingress_lb_service_name          = string
    ingress_lb_shape                 = string
    ingress_enable_http_port         = bool
    ingress_enable_https_port        = bool
    ingress_http_port                = string
    ingress_https_port               = string
    jenkins_namespace                = string
    wls-domain_namespace             = string
    cert_secret_name                 = string
    lb_name                          = string
    lb_namespace                     = string
    shape                            = string
    is_internal                      = bool
    https_port                       = number
  })
}


variable "oke_cluster_id" {
  type = string
}

# kubeconfig
variable "cluster_kube_config_expiration" {
  default = 2592000
}

variable "cluster_kube_config_token_version" {
  default = "2.0.0"
}

variable "atp_attributes" {
  type = object({
    atp_db_id    = string
    atp_db_level = string
  })
}

variable "fss_id" {
  type = string
}


