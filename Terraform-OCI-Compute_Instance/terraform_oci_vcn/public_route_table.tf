#resource block for route table with route rule for internet gateway
resource "oci_core_route_table" "publicRT" {
  vcn_id = "${oci_core_vcn.test_vcn.id}"
compartment_id = "${var.compartment_ocid}"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.test_internet_gateway.id}"
  }
}
