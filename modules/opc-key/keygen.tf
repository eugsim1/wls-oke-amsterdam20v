/*
 * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
 */
resource "tls_private_key" "opc_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}