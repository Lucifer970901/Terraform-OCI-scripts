#this file contains the output from resources deployed

output "show-ads" {
  value = "${data.oci_identity_availability_domains.ADs.availability_domains}"
}

#output from vcn and subnets
output "vcn_id" {
value = "${lookup(data.oci_core_vcns.test_vcns.virtual_networks[0],"id")}"
}
output "vcn_display_name" {
value = "${lookup(data.oci_core_vcns.test_vcns.virtual_networks[0],"display_name")}"
}

output "subnet_id"{
value = "${lookup(data.oci_core_subnets.test_subnets.subnets[0],"id")}"
}

output "subnet_display_name"{
value = "${lookup(data.oci_core_subnets.test_subnets.subnets[0],"display_name")}"
}
#output from linux instance.
output "instance_id"{
value = "${oci_core_instance.linux.*.id}"
}

output "assigned_public_ip" {
 description = "Public IPs of created instances. "
 value       = "${oci_core_instance.linux.*.public_ip}"

}
