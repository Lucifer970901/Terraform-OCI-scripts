#data "oci_identity_regions" "test_regions" {
#
#}

#resource block for compartment
resource "oci_identity_compartment" "compartment" {
  provider       = oci.home
  compartment_id = var.compartment_ocid
  description    = "create a comparment within your oci compartment"
  name           = "compartment_created_using_terraform"
  #region  = "${var.home_region}"
}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [oci_identity_compartment.compartment]

  create_duration = "60s"
}

# This resource will create (at least) 30 seconds after oci_identity_compartment.comparment

#resource block for oci vcn.
resource "oci_core_vcn" "test_vcn" {
  #Required
  depends_on = [time_sleep.wait_60_seconds]
  provider       = oci.region2
  cidr_block     = var.vcn_cidr_block
  compartment_id = oci_identity_compartment.compartment.id
  #compartment_id = "${var.compartment_ocid}"
}
