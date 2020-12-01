# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  admin_ip = var.oci_admin.use_public_ip==true?var.oci_admin.admin_public_ip: var.oci_admin.admin_private_ip
  nfs_mount_ip=var.fss_attributes.nfs_mount_ip
  nfs_export_path=var.fss_attributes.nfs_export_path
  ocir_regions = distinct(concat(list(upper(var.jenkins_attributes.ocir_default_region)), var.jenkins_attributes.ocir_regions))
}