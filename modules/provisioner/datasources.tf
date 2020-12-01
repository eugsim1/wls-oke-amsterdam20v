# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.


#kubeconfig
data "oci_containerengine_cluster_kube_config" "kube_config" {
  cluster_id    = var.oke_cluster_id
  expiration    = var.cluster_kube_config_expiration
  token_version = var.cluster_kube_config_token_version
}

#FSS template
data "template_file" "fss_inputs" {
  template = file("${path.module}/templates/fss-template.tpl")

  vars = {
    nfs_mount_path   = local.nfs_export_path
    nfs_mount_ip     = local.nfs_mount_ip
    mount_target_id  = var.fss_attributes.mount_target_id
    nfs_mount_path   = local.nfs_export_path
    fss_chart_name   = var.fss_attributes.fss_chart_name
    ocir_secret_name = var.fss_attributes.ocir_secret_name
  }
}

#Jenkins template
data "template_file" "jenkins_inputs" {
  template = file("${path.module}/templates/jenkins-template.tpl")

  vars = {
    ocir_jenkins_repo              = var.jenkins_attributes.ocir_jenkins_repo
    jenkins_master_version         = var.jenkins_attributes.jenkins_master_version
    jenkins_pull_secret            = var.jenkins_attributes.jenkins_pull_secret
    jenkins_replica_count          = var.jenkins_attributes.jenkins_replica_count
    jenkins_container_port         = var.jenkins_attributes.jenkins_container_port
    jenkins_service_port           = var.jenkins_attributes.jenkins_service_port
    jenkins_service_nodeport       = var.jenkins_attributes.jenkins_service_nodeport
    jenkins_service_targetport     = var.jenkins_attributes.jenkins_service_targetport
    jenkins_service_jnlpport       = var.jenkins_attributes.jenkins_service_jnlpport
    jenkins_service_jnlpnodeport   = var.jenkins_attributes.jenkins_service_jnlpnodeport
    jenkins_service_jnlptargetport = var.jenkins_attributes.jenkins_service_jnlptargetport
    jenkins_name                   = var.jenkins_attributes.jenkins_name
    jenkins_namespace              = var.jenkins_attributes.jenkins_namespace
    jenkins_proxy                  = var.jenkins_attributes.jenkins_proxy
    kube_url                       = var.jenkins_attributes.kube_url
    jenkins_home                   = var.jenkins_attributes.jenkins_home
    jenkins_host_volume_mount_path = var.jenkins_attributes.jenkins_host_volume_mount_path
    jenkins_servicename            = var.jenkins_attributes.jenkins_servicename
    oke_mount_path                 = var.jenkins_attributes.oke_mount_path
    nfs_mount_path                 = local.nfs_export_path
    nfs_mount_ip                   = local.nfs_mount_ip
    mount_target_id                = var.fss_attributes.mount_target_id
    fss_chart_name                 = var.fss_attributes.fss_chart_name
    jenkins_cert_secret_mount_path = var.jenkins_attributes.jenkins_cert_secret_mount_path
    jenkins_cert_secret            = var.jenkins_attributes.jenkins_cert_secret

  }
}

data "template_file" "ingress_inputs" {
  template = file("${path.module}/templates/ingress-template.tpl")

  vars = {
    ocir_ingress_image               = var.ingress_attributes.ocir_ingress_image
    admin-service                    = var.ingress_attributes.admin-service
    admin-service-port               = var.ingress_attributes.admin-service-port
    cluster-service                  = var.ingress_attributes.cluster-service
    cluster-service-port             = var.ingress_attributes.cluster-service-port
    jenkins-service                  = var.ingress_attributes.jenkins-service
    jenkins-service-port             = var.ingress_attributes.jenkins-service-port
    ingress_namespace                = var.ingress_attributes.ingress_namespace
    ingress_ocir_secret_name         = var.ingress_attributes.ingress_ocir_secret_name
    ingress_lb_service_name          = var.ingress_attributes.ingress_lb_service_name
    ingress_lb_shape                 = var.ingress_attributes.ingress_lb_shape
    ingress_enable_http_port         = var.ingress_attributes.ingress_enable_http_port
    ingress_enable_https_port        = var.ingress_attributes.ingress_enable_https_port
    ingress_http_port                = var.ingress_attributes.ingress_http_port
    ingress_https_port               = var.ingress_attributes.ingress_https_port
    jenkins_namespace                = var.ingress_attributes.jenkins_namespace
    wls-domain_namespace             = var.ingress_attributes.wls-domain_namespace
    cert_secret_name                 = var.ingress_attributes.cert_secret_name
    lb_name                          = var.ingress_attributes.lb_name
    lb_namespace                     = var.ingress_attributes.lb_namespace
    lb_shape                         = var.ingress_attributes.shape
    is_internal                      = var.ingress_attributes.is_internal
    service_ssl_port                 = var.ingress_attributes.https_port
  }
}
