#resource block for creating private subnet
resource "oci_core_subnet" "privatesubnet"{
dns_label = "PrivateSubnet"
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.test_vcn.id}"
display_name = "${var.display_name_privatesubnet}"
cidr_block = "${var.cidr_block_privatesubnet}"
prohibit_public_ip_on_vnic = "true"
route_table_id = "${oci_core_route_table.privateRT.id}"
security_list_ids = ["${oci_core_security_list.privateSL.id}"]
}