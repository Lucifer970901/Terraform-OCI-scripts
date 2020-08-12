// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

data "oci_core_vcns" "test_vcns" {
    #Required
    compartment_id = "${var.compartment_ocid}"

    #Optional
    display_name = "${var.vcn_display_name}"
}
data "oci_core_subnets" "test_subnets" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${lookup(data.oci_core_vcns.test_vcns.virtual_networks[0],"id")}"

    #Optional
    display_name = "${var.subnet_display_name}"
}

resource "oci_core_network_security_group" "test_network_security_group" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${lookup(data.oci_core_vcns.test_vcns.virtual_networks[0],"id")}"
  display_name   = "displayName"
}

resource "oci_core_network_security_group" "test_network_security_group_backup" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${lookup(data.oci_core_vcns.test_vcns.virtual_networks[0],"id")}"
  display_name   = "displayName"
}
