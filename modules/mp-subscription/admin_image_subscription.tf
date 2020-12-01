# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

#Get Image Agreement
resource "oci_core_app_catalog_listing_resource_version_agreement" "admin_mp_image_agreement" {
  count = (var.admin_mp_subscription.use_marketplace_image ? 1 : 0)
  listing_id               = var.admin_mp_subscription.mp_listing_id
  listing_resource_version = var.admin_mp_subscription.mp_listing_resource_version
}

#Accept Terms and Subscribe to the image, placing the image in a particular compartment
resource "oci_core_app_catalog_subscription" "admin_mp_image_subscription" {
  compartment_id           = var.admin_mp_subscription.compartment_id
  eula_link                = oci_core_app_catalog_listing_resource_version_agreement.admin_mp_image_agreement[0].eula_link
  listing_id               = oci_core_app_catalog_listing_resource_version_agreement.admin_mp_image_agreement[0].listing_id
  listing_resource_version = oci_core_app_catalog_listing_resource_version_agreement.admin_mp_image_agreement[0].listing_resource_version
  oracle_terms_of_use_link = oci_core_app_catalog_listing_resource_version_agreement.admin_mp_image_agreement[0].oracle_terms_of_use_link
  signature                = oci_core_app_catalog_listing_resource_version_agreement.admin_mp_image_agreement[0].signature
  time_retrieved           = oci_core_app_catalog_listing_resource_version_agreement.admin_mp_image_agreement[0].time_retrieved

  timeouts {
    create = "20m"
  }
  count = (var.admin_mp_subscription.use_marketplace_image ? 1 : 0)
}

# Gets the partner image subscription
data "oci_core_app_catalog_subscriptions" "admin_mp_image_subscription" {
  #Required
  compartment_id = var.admin_mp_subscription.compartment_id

  #Optional
  listing_id = var.admin_mp_subscription.mp_listing_id

  filter {
    name   = "listing_resource_version"
    values = [var.admin_mp_subscription.mp_listing_resource_version]
  }
  count = (var.admin_mp_subscription.use_marketplace_image ? 1 : 0)
}