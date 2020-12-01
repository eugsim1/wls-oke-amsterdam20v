# Copyright  2019, Oracle Corporation and/or affiliates.  All rights reserved.

#Variables to be added based WLS version
#to be added as part of the MP build

variable "jenkins_master_version" {
  description = "jenkins master version"
  default     = "1.0.0"
}

variable "jenkins_namespace" {
  description = "jenkins namespace"
  default     = "jenkins-ns"
}

variable "jenkins_servicename" {
  description = "jenkins service name"
  default     = "jenkins-service"
}

variable "jenkins_replica_count" {
  description = "jenkins replica count"
  default     = "1"
}

variable "jenkins_pull_secret" {
  description = "secret for docker creds"
  default     = "ocirsecrets"
}

variable "jenkins_container_port" {
  description = "jenkins container port"
  default     = "8080"
}

variable "jenkins_service_port" {
  description = "jenkins service port"
  default     = "8080"
}

variable "jenkins_service_nodeport" {
  description = "jenkins service nodeport"
  default     = "31125"
}

variable "jenkins_service_targetport" {
  description = "jenkins service targetport"
  default     = "8080"
}

variable "jenkins_service_jnlpnodeport" {
  description = "jenkins service jnlp node port"
  default     = "32554"
}

variable "jenkins_service_jnlpport" {
  description = "jenkins service port"
  default     = "50000"
}

variable "jenkins_service_jnlptargetport" {
  description = "jenkins service jnlp targetport"
  default     = "50000"
}

variable "jenkins_name" {
  description = "jenkins name"
  default     = "jenkins-oke"
}

variable "jenkins_proxy" {
  description = "jenkins proxy"
  default     = ""
}

variable "jenkins_cert_secret_mount_path" {
  description = "jenkins cert secret mount path"
  default     = "/home/ca/.tls"
}

variable "kube_url" {
  description = "kubernetes server url"
  default     = "https://kubernetes.default.svc:443/"
}

variable "jenkins_home" {
  description = "jenkins administration home directory"
  default     = "/var/jenkins_home"
}

variable "jenkins_host_volume_mount_path" {
  description = "jenkins host volume mount path"
  default     = "/var/run/docker.sock"
}