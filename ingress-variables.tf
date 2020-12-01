# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.

#Variables to be added based WLS version
#to be added as part of the MP build

variable "ingress_namespace" {
  description = "ingress namespace"
  default     = "ingress-nginx"
}

variable "ingress_replica_count" {
  description = "ingress replica count"
  default     = "1"
}

variable "ingress_pull_secret" {
  description = "secret for docker creds"
  default     = "ocirsecrets"
}

variable "ingress_lb_shape" {
  description = "Shape of the ingress load balancer"
  default     = "100Mbps"
}

variable "ingress_enable_http_port" {
  description = "Enable http port on ingress load balancer"
  default     = true
}

variable "ingress_enable_https_port" {
  description = "Enable https port on ingress load balancer"
  default     = false
}

variable "ingress_http_port" {
  description = "Http port for ingress load balancer"
  default     = "80"
}

variable "ingress_https_port" {
  description = "Https port for ingress load balancer"
  default     = "443"
}

variable "ingress_private_lb" {
  description = "type of load balancer."
  default     = false
}