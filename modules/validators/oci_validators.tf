# 
/*
locals {
  
  insufficient_lb     = (data.oci_limits_resource_availability.lb_resource_availability < 2 ) ? true : null
  insufficient_lb_msg = "WLSOKE-ERROR: Insufficient resources for laodbalances=[${data.oci_limits_resource_availability.lb_resource_availability}]]"
}
*/