#this file contains the output from resources deployed

output "show-ads" {
  value = "${data.oci_identity_availability_domains.ADs.availability_domains}"
}

#output from vcn and subnets
output "vcn_id" {
value = "${var.vcn_id}"
}

output "public_subnet_id"{
value = "${var.subnet_id}"
}

#output from linux instance.
output "instance_id"{
value = "${oci_core_instance.linux.*.id}"
}

output "assigned_public_ip" {
 description = "Public IPs of created instances. "
 value       = "${oci_core_instance.linux.*.public_ip}"

}
