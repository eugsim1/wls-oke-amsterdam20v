/*
 * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
 */
output "OPCPrivateKey" {
  value = "${map("public_key_openssh", tls_private_key.opc_key.public_key_openssh, "private_key_pem", tls_private_key.opc_key.private_key_pem)}"
}
