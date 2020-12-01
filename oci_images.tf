# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

variable "marketplace_source_images" {
  type = map(object({
    ocid                  = string
    is_pricing_associated = bool
    compatible_shapes     = set(string)
  }))
  default = {
    main_mktpl_image = {
      ocid                  = "ocid1.image.oc1..aaaaaaaaibbsg23uasf77j4kdldnjnbmgkfjxd5gqywabs3hwx2jw45pj24q"
      is_pricing_associated = true
      compatible_shapes     = []
    }
    bastion_image = {
      ocid                  = "ocid1.image.oc1..aaaaaaaatbokpfj2x3oio7ibv7tuzl3twuqpfeuwq4xcy4xr6hekjzuccuza"
      is_pricing_associated = false
      compatible_shapes     = []
    }
    admin_image = {
      ocid                  = "ocid1.image.oc1..aaaaaaaabyizs5d7olwpd77wzycin4zdn5uk2cx2zpx2peuzwfw7vaesmmda"
      is_pricing_associated = false
      compatible_shapes     = []
    }
  }
}
