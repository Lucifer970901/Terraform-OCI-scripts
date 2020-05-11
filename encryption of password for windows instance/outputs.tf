#output of vcn block
output "vcn_id" {
  value = "${oci_core_vcn.vcn1.id}"
}

output "internet_gateway_id" {
  value = "${oci_core_internet_gateway.vcn1.id}"
}

output "show-availability_domain" {
  value = "${data.oci_identity_availability_domain.ad.name}"
}

output "public_route_table_id" {
  value = "${oci_core_route_table.publicRT.id}"
}

output "public_subnet_id" {
  value = "${oci_core_subnet.publicsubnet.id}"
}

#outputs of instance block
output "instance_id" {
 description = "ocid of created instances. "
 value       = "${oci_core_instance.this.*.id}"
}

output "private_ip" {
description = "Private IPs of created instances. "
value       = "${oci_core_instance.this.*.private_ip}"
}

output "assign_public_ip" {
 description = "Public IPs of created instances. "
 value       = "${oci_core_instance.this.*.public_ip}"

}

#outputs of vault and secret block
output "oci_vault" {
  value = "${data.oci_kms_vault.test_vault.id}"
}

output "oci_key" {
  value = "${data.oci_kms_key.test_key.id}"
}
output "vault_display_name"{
value  = "${data.oci_kms_vault.test_vault.display_name}"
}

output "key_display_name"{
value = "${data.oci_kms_key.test_key.display_name}"
}

#comment the next lines if you do not want to see the encrypted and decrypted data.
output "encrypted_data"{
value ="${oci_kms_encrypted_data.test_encrypted_data.ciphertext}"
}

output"decrypted_data"{
value = base64decode("${data.oci_kms_decrypted_data.test_decrypted_data.plaintext}")
}
