# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

data "oci_identity_tenancy" "tenancy" {
  #Required
  tenancy_id = "${var.tenancy_ocid}"
}


data "oci_objectstorage_namespace" "object_namespace" {

  #Optional
  compartment_id = "${var.tenancy_ocid}"
}


data "oci_identity_region_subscriptions" "tenancy_region_subscriptions" {
  #Required
  tenancy_id = "${var.tenancy_ocid}"
}


data "oci_identity_regions" "all_regions" {
}

data "oci_identity_regions" "home-region" {
  filter {
    name   = "key"
    values = ["${data.oci_identity_tenancy.tenancy.home_region_key}"]
  }
}






data "oci_file_storage_mount_targets" "fss_mountTarget" {
  count = var.mountTarget_id != "" && var.mountTarget_compartment_id != "" ? 1 : 0

  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name ##var.fss_availability_domain
  compartment_id      = var.mountTarget_compartment_id
  id                  = var.mountTarget_id
}

data "oci_core_subnet" "mountTarget_subnet" {
  count     = var.mountTarget_id != "" && var.mountTarget_compartment_id != "" ? 1 : 0
  subnet_id = data.oci_file_storage_mount_targets.fss_mountTarget[0].mount_targets[0].subnet_id
}


data "oci_identity_availability_domains" "availability_domains" {
  #Required
  compartment_id = var.tenancy_ocid
}


data "oci_limits_resource_availability" "lb_resource_availability" {
    #Required
    compartment_id = var.tenancy_ocid
    limit_name = "lb-100mbps-count"
    service_name = "load-balancer"

    #Optional
    ##availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name
}	

output "lb_resource_availability" {
value = data.oci_limits_resource_availability.lb_resource_availability
}

data "oci_limits_resource_availability" "VM_resource_availability" {
    #Required
    compartment_id = var.tenancy_ocid
    limit_name = "vm-standard2-1-count"
    service_name = "compute"

    #Optional
    availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name
}	

output "VM_resource_availability" {
value = data.oci_limits_resource_availability.VM_resource_availability
}


data "oci_limits_resource_availability" "filesystem_resource_availability" {
    #Required
    compartment_id = var.tenancy_ocid
    limit_name = "mount-target-count"
    service_name = "filesystem"

    #Optional
    availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name
}	

output "filesystem_resource_availability" {
value = data.oci_limits_resource_availability.filesystem_resource_availability
}

data "oci_limits_services" "test_services" {
    #Required
    compartment_id = var.tenancy_ocid
}

output "oci_services" {
value = data.oci_limits_services.test_services.services.*.name
}

output "availability_domains_name" {
  value = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name
}

