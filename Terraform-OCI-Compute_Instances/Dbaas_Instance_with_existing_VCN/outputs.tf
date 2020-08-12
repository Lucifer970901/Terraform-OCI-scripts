// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
# Output the public IP of the instance

output "db_node_public_ip" {
    value = ["${data.oci_core_vnic.db_node_vnic.public_ip_address}"]
}

output "ssh-public-key_in_openssh_format" {
    value = ["${tls_private_key.public_private_key_pair.public_key_openssh}"]
}
output "ssh-private-key_pem" {
value = ["${tls_private_key.public_private_key_pair.private_key_pem}"]
}
output "ssh-public-key_pem" {
value = ["${tls_private_key.public_private_key_pair.public_key_pem}"]
}
