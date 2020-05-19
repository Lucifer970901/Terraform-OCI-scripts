#output of vcn block
output "vcn_id" {
  value = "${oci_core_vcn.vcn1.id}"
}

output "internet_gateway_id" {
  value = "${oci_core_internet_gateway.vcn1.id}"
}

output "show-availability_domain" {
  value = "${data.oci_identity_availability_domains.ads.availability_domains}"
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
