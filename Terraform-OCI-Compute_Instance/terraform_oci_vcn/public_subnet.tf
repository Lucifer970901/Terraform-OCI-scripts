#resource block for defining public subnet
resource "oci_core_subnet" "publicsubnet"{
dns_label = "${var.publicSubnet_dns_label}"
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.test_vcn.id}"
display_name = "${var.display_name_publicsubnet}"
cidr_block = "${var.cidr_block_publicsubnet}"
route_table_id = "${oci_core_route_table.publicRT.id}"
security_list_ids = ["${oci_core_security_list.publicSL.id}"]
}