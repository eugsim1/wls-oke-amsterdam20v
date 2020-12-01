# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.
/*
# Gets a list of VNIC attachments on the admin instance
data "oci_core_vnic_attachments" "admin_vnics_attachments" {
  availability_domain = var.oci_admin.availability_domain
  compartment_id      = var.oci_identity.compartment_id
  instance_id         = oci_core_instance.admin.id
}

# Gets the OCID of the first (default) VNIC on the admin instance
data "oci_core_vnic" "admin_vnic" {
  vnic_id = data.oci_core_vnic_attachments.admin_vnics_attachments.id
}
*/
data "oci_core_instance" "admin" {
  #Required
  instance_id = oci_core_instance.admin.id
}

data "oci_database_autonomous_database" "atp_db" {
  count = local.is_atp_db ? 1 : 0

  #Required
  autonomous_database_id = var.oci_metadata_attrs.atp_db_id
}

data "oci_database_db_systems" "ocidb_db_systems" {
  count = local.is_oci_db? 1: 0

  #Required
  compartment_id = var.oci_metadata_attrs.ocidb_compartment_id

  filter {
    name   = "id"
    values = [var.oci_metadata_attrs.ocidb_dbsystem_id]
  }
}

data "oci_database_database" "ocidb_database" {
  count = local.is_oci_db? 1: 0

  #Required
  database_id = var.oci_metadata_attrs.ocidb_database_id
}

data "oci_database_db_home" "ocidb_db_home" {
  count = local.is_oci_db? 1: 0

  #Required
  db_home_id = data.oci_database_database.ocidb_database[count.index].db_home_id
}