# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  all_protocols = "all"
  anywhere      = "0.0.0.0/0"
  ssh_port      = 22
  tcp_protocol  = 6

  private_subnet= var.admin_vcn_config.assign_public_ip?false:true
  admin_subnet_id= element(coalescelist(oci_core_subnet.admin_subnet.*.id, list(var.admin_vcn_config.existing_subnet_id)),0)
}

