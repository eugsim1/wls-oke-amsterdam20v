# Copyright 2019, 2020, Oracle Corporation and/or affiliates.  All rights reserved.

output "subnet_ids" {
  value = map(
    "workers", join(",", local.oke_workers_subnet_ids),
    "lb", join(",", local.lb_subnet_ids)
  )
}