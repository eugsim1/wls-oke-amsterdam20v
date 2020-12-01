# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_core_security_list" "admin_security_list" {
    lifecycle {
        ignore_changes = [ "freeform_tags" , "defined_tags",  ]
    }
  count = var.admin_vcn_config.existing_subnet_id==""?1:0

  compartment_id = var.admin_vcn_config.compartment_id
  display_name   = "${var.label_prefix}-admin-seclist"
  vcn_id         = var.admin_vcn_config.vcn_id

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  ingress_security_rules {
    # allow ssh
    protocol = local.tcp_protocol
    source   = var.admin_vcn_config.admin_access_cidr == "ANYWHERE" ? local.anywhere : var.admin_vcn_config.admin_access_cidr
    description = "SSH access to admin host from bastion"
    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
  }
}
