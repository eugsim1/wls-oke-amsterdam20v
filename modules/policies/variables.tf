# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

# Identity and access parameters

variable "oci_identity" {
  type = object({
    network_compartment_id = string
    compartment_id         = string
    tenancy_id             = string
    ssh_public_key         = string
    opc_ssh_private_key    = string
    opc_ssh_public_key     = string
  })
}

variable "label_prefix" {}

variable "atp_compartment_id" {}

variable "is_atp" {
  default = false
  type    = bool
}

variable "create_policies" {
  type    = bool
  default = true
}

variable "oci_wls_secrets" {
  type = object({
    wls_admin_password_secret_ocid = string
    db_password_secret_ocid        = string
    ocir_auth_token_secret_ocid    = string
  })
}

variable "oke_secret_enc" {
  type = object({
    use_encryption = bool
    key_ocid         = string
  })
}

