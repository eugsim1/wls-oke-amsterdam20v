# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

variable "oci_identity" {
  type = object({
    network_compartment_id      = string
    compartment_id      = string
    tenancy_id          = string
    ssh_public_key      = string
    opc_ssh_private_key = string
    opc_ssh_public_key  = string
    region              = string
  })
}

variable "oci_bastion" {
  type = object({
    label_prefix        = string
    instance_shape      = string
    availability_domain = string
    instance_image_id   = string
    subnet_id           = string
  })
}