# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

locals {
  is_atp_db    = trimspace(var.oci_metadata_attrs.atp_db_id) != "" ? true : false
  is_oci_db    = trimspace(var.oci_metadata_attrs.ocidb_dbsystem_id) != "" ? true : false
  is_apply_JRF = local.is_oci_db || local.is_atp_db ? true : false
}
