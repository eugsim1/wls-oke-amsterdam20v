# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_file_storage_export" "mount_export" {
    
  #Required
  export_set_id  = oci_file_storage_export_set.mount_export_set.id
  file_system_id = oci_file_storage_file_system.file_system.id
  path           = var.oci_fss.export_path

  #Optional
  export_options {
    #Required
    source = local.vcn_cidr

    access          = "READ_WRITE"
    identity_squash = "NONE"
  }
}
