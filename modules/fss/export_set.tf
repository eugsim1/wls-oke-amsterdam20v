# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_file_storage_export_set" "mount_export_set" {
  #Required
  mount_target_id = local.mount_target_id[0]
  display_name = "${var.oci_fss.label_prefix}-export-set"
}
