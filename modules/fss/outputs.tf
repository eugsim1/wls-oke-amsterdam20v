# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

output "mountTarget_id" {
  value = local.mount_target_id[0]
}

output "mount_export_id" {
  value = oci_file_storage_export.mount_export.id
}

output "fss_id" {
  value=oci_file_storage_file_system.file_system.id
}

output "nfs_mount_ip" {
  value = data.oci_core_private_ip.mount_target_private_ip.ip_address
}

output "nfs_export_path" {
  value = data.oci_file_storage_exports.fss_exports.exports[0].path
}
