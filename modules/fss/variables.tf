# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.

variable "oci_fss" {
  type = object({
    compartment_id              = string
    availability_domain         = string
    vcn_id                      = string
    label_prefix                = string
    export_path                 = string
    mountTarget_id              = string
    subnet_id                   = string
    mountTarget_compartment_id = string


    # policy dependency
    bastion_public_ip = string
    ssh_private_key    = string
  })
}