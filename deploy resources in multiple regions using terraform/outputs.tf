output "vcn_id" {
  value = oci_core_vcn.test_vcn.id
}

output "compartment_id" {
  value = oci_identity_compartment.compartment.id
}

