#this file contains the output from resources deployed

output "show-ad" {
  value = "${data.oci_identity_availability_domain.ad.name}"
}

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

output "private_subnet_id"{
value = "${oci_core_subnet.privatesubnet.id}"
}
output "private_route_table_id"{
value = "${oci_core_route_table.privateRT.id}"
}
output "private_securitylist_id"{
value = "${oci_core_security_list.privateSL.id}"
}

