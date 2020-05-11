output "vcn_id" {
  description = "ocid of created VCN. "
  value       = "${oci_core_vcn.this.id}"
}

output "default_security_list_id" {
  description = "ocid of default security list. "
  value       = "${oci_core_vcn.this.default_security_list_id}"
}

output "default_dhcp_options_id" {
  description = "ocid of default DHCP options. "
  value       = "${oci_core_vcn.this.default_dhcp_options_id}"
}

output "default_route_table_id" {
  description = "ocid of default route table. "
  value       = "${oci_core_vcn.this.default_route_table_id}"
}

output "internet_gateway_id" {
  description = "ocid of internet gateway. "
  value       = "${oci_core_internet_gateway.this.id}"
}

output "subnet_ids" {
  description = "ocid of subnet ids. "
  value       = "${oci_core_subnet.this.*.id}"
}
output "instance_id" {
  description = "ocid of created instances. "
  value       = ["${oci_core_instance.this.*.id}"]
}

output "private_ip" {
  description = "Private IPs of created instances. "
  value       = ["${oci_core_instance.this.*.private_ip}"]
}

output "public_ip" {
  description = "Public IPs of created instances. "
  value       = ["${oci_core_instance.this.*.public_ip}"]
}

output "instance_username" {
  description = "Usernames to login to Windows instance. "
  value       = ["${data.oci_core_instance_credentials.this.*.username}"]
}

output "instance_password" {
  description = "Passwords to login to Windows instance. "
  sensitive   = true
  value       = ["${data.oci_core_instance_credentials.this.*.password}"]
}