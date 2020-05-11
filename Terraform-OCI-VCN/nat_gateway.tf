#resource block for creating nat gateway
resource "oci_core_nat_gateway" "test_nat_gateway" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.test_vcn.id}"
}
