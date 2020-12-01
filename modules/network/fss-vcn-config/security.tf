# Copyright  2020, Oracle Corporation and/or affiliates.  All rights reserved.

# public worker security checklist
resource "oci_core_security_list" "fss_seclist" {
  count = var.fss_vcn_config.existing_fss_subnet_id==""?1:0

  compartment_id = var.compartment_id
  display_name   = "${var.label_prefix}-fss-seclist"
  vcn_id         = var.fss_vcn_config.vcn_id

  egress_security_rules {
    destination = local.vcn_cidr
    protocol  = "6"         // tcp
    stateless = false
    tcp_options {
       source_port_range {
         max = 2050
         min = 2048
       }
     }
  }

  egress_security_rules {
    protocol  = "6"         // tcp
    destination = local.vcn_cidr
    stateless = false
    tcp_options {
      source_port_range {
        max = 111
        min = 111
      }
    }
  }

  egress_security_rules {
    protocol  = "17"         // udp
    destination = local.vcn_cidr
    stateless = false
    udp_options {
      source_port_range {
        max = 111
        min = 111
      }
    }
  }


  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = local.vcn_cidr
    stateless = false
    tcp_options {
      min = 2048
      max = 2050
    }
  }

  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = local.vcn_cidr
    stateless = false
    tcp_options {
      min = 111
      max = 111
    }
  }

  ingress_security_rules {
    protocol  = "17"         // udp
    source    = local.vcn_cidr
    stateless = false
    udp_options {
      min = 2048
      max = 2048
    }
  }

  ingress_security_rules {
    protocol  = "17"         // udp
    source    = local.vcn_cidr
    stateless = false
    udp_options {
      min = 111
      max = 111
    }
  }

}
