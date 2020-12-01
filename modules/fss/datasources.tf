# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.


data "oci_file_storage_mount_targets" "fss_mount_targets" {
  #Required
  availability_domain = var.oci_fss.availability_domain
  compartment_id = var.oci_fss.mountTarget_compartment_id

  #Optional
  id = local.mount_target_id[0]
}

#to get export path
data "oci_file_storage_exports" "fss_exports" {
  compartment_id = var.oci_fss.mountTarget_compartment_id
  id = oci_file_storage_export.mount_export.id
}


#get the mount target ip
data "oci_core_private_ip" "mount_target_private_ip" {
  #Required
  private_ip_id = data.oci_file_storage_mount_targets.fss_mount_targets.mount_targets[0].private_ip_ids[0]
}
