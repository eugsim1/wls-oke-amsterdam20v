# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_file_storage_file_system" "file_system" {
    lifecycle {
        ignore_changes = [ "freeform_tags" , "defined_tags",  ]
    }

  #Required
  availability_domain = var.oci_fss.availability_domain
  compartment_id      = var.oci_fss.compartment_id

  display_name = "${var.oci_fss.label_prefix}-fss"
}
