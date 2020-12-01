# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.


data "oci_core_subnet" "bastion_subnet" {
  #Required
  subnet_id = (element(concat(oci_core_subnet.bastion_subnet.*.id ,list(var.bastion_vcn_config.existing_subnet_id)),0))
}
