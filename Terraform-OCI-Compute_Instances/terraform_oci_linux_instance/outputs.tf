#this file contains the output from resources deployed

output "show-ad" {
  value = "${data.oci_identity_availability_domains.ads.availability_domains}"
}

#output from vcn and subnets
output "vcn_id" {
value = "${oci_core_vcn.test_vcn.id}"
}
output "internet_gateway_id"{
value = "${oci_core_internet_gateway.test_internet_gateway.id}"
}

output "public_subnet_id"{
value = "${oci_core_subnet.publicsubnet.id}"
}
output "public_route_table_id"{
value = "${oci_core_route_table.publicRT.id}"
}
output "public_securitylist_id"{
value = "${oci_core_security_list.publicSL.id}"
}

#output from linux instance.
output "instance_id"{
value = "${oci_core_instance.linux.*.id}"
}

output "assigned_public_ip" {
 description = "Public IPs of created instances. "
 value       = "${oci_core_instance.linux.*.public_ip}"

}
