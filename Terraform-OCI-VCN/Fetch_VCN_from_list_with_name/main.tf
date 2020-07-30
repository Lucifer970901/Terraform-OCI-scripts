data "oci_core_vcns" "test_vcns" {
    #Required
    compartment_id = "${var.compartment_ocid}"

    #Optional
    display_name = "${var.vcn_display_name}"

}
output "vcn_id"{
value = "${lookup(data.oci_core_vcns.test_vcns.virtual_networks[0],"id")}"
}
output "vcn_details"{
value = "${data.oci_core_vcns.test_vcns.virtual_networks}"
}
