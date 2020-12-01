# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_file_storage_mount_target" "mount_target" {
    lifecycle {
        ignore_changes = [ "freeform_tags" , "defined_tags",  ]
    }
    #Required
    availability_domain = var.oci_fss.availability_domain
    compartment_id = var.oci_fss.compartment_id
    subnet_id = var.oci_fss.subnet_id

    display_name = "${var.oci_fss.label_prefix}-mntTarget"
    hostname_label = "${var.oci_fss.label_prefix}-mntTarget"
    count = var.oci_fss.mountTarget_id==""?1:0
}