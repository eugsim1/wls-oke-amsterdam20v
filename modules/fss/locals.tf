# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.


data "oci_core_vcn" "oke_vcn" {
  #Required
  vcn_id = var.oci_fss.vcn_id
}

locals {
  anywhere="0.0.0.0/0"
  vcn_cidr= data.oci_core_vcn.oke_vcn.cidr_block
  mount_target_id=coalescelist(oci_file_storage_mount_target.mount_target.*.id,list(var.oci_fss.mountTarget_id))
}
