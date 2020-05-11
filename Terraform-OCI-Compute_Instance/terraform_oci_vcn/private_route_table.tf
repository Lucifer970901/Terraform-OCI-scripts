#resource for creating private route table
resource "oci_core_route_table" "privateRT"{
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.test_vcn.id}"
display_name = "private_route_table"
}
