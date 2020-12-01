# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  # security rules locals - used by security
  all_protocols = "all"

  anywhere = "0.0.0.0/0"

  icmp_protocol = 1

  pub_cidr_blocks = ["130.35.0.0/16", "134.70.0.0/17", "138.1.0.0/16", "140.91.0.0/17", "147.154.0.0/16", "192.29.0.0/16", "0.0.0.0/0"]

  node_port_min = 30000

  node_port_max = 32767

  ssh_port = 22

  tcp_protocol = 6

  has_existing_lb_subnet_id= var.oke_vcn_config.existing_lb_subnet_id==""?false:true
  has_existing_oke_workers_subnet_id= var.oke_vcn_config.existing_oke_workers_subnet_id==""?false:true

  oke_workers_subnet_ids=coalescelist(oci_core_subnet.oke_workers_subnet.*.id,list(var.oke_vcn_config.existing_oke_workers_subnet_id))

  lb_subnet_ids=coalescelist(oci_core_subnet.lb_subnet.*.id,list(var.oke_vcn_config.existing_lb_subnet_id))

}
