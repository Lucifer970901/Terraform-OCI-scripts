#resource block for oci vcn.
resource "oci_core_vcn" "test_vcn" {
    #Required
    cidr_block = "${var.vcn_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    
}