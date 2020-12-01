# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  all_protocols = "all"
  anywhere      = "0.0.0.0/0"
  ssh_port      = 22
  tcp_protocol  = 6

  bastion_subnet_id= element(coalescelist(oci_core_subnet.bastion_subnet.*.id, list(var.bastion_vcn_config.existing_subnet_id)),0)
}

