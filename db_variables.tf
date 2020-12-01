# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.

variable "add_JRF" {
  type    = bool
  default = false
}

variable "atp_db_compartment_id" {
  description = "ATP DB Compartment OCID"
  default     = ""
}

variable "atp_db_id" {
  description = "ATP DB OCID"
  default     = ""
}

variable "atp_db_level" {
  description = "ATP DB Service Level"
  default     = "low"
}

variable "atp_db_password_ocid" {
  description = "Secrets OCID for ATP DB Admin password"
  default     = ""
}

/*
********************
OCI DB Config
********************
*/
// Provide DB node count - for node count > 1, WLS AGL datasource will be created

variable "ocidb_compartment_id" {
  description = "DB System Compartment ID"
  default     = ""
}

//variable "ocidb_network_compartment_id" {
//  description = "DB System Network Compartment ID"
//  default = ""
//}
//
//variable "ocidb_existing_vcn_id" {
//  description = "DB System VCN ID"
//  default = ""
//}

variable "ocidb_dbsystem_id" {
  description = "DB System OCID"
  default     = ""
}

variable "ocidb_dbhome_id" {
  description = "DB Home OCID"
  default     = ""
}

variable "ocidb_database_id" {
  description = "DB OCID"
  default     = ""
}

variable "ocidb_pdb_service_name" {
  description = "PDB Service Name or PDB Name"
  default     = ""
}

variable "oci_db_user" {
  description = "DB SYS User"
  default     = "SYS"
}

variable "oci_db_password_ocid" {
  description = "Secrets OCID for DB SYS user password"
  default     = ""
}

variable "db_port" {
  default = "1521"
}