#declare the resources to be deployed
#creates vcn
resource "oci_core_vcn" "vcn1" {
  cidr_block     = "192.0.0.0/16"
  dns_label      = "vcn1"
  compartment_id = "${var.compartment_ocid}"
    display_name   = "vcn1"
}

#creates internet gateway
resource "oci_core_internet_gateway" "vcn1" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"
}

#creates public subnet
resource "oci_core_subnet" "publicsubnet" {
  dns_label         = "publicSubnet"
  compartment_id    = "${var.compartment_ocid}"
  vcn_id            = "${oci_core_vcn.vcn1.id}"
  display_name      = "public_subnet"
  cidr_block        = "192.0.1.0/24"
  route_table_id    = "${oci_core_route_table.publicRT.id}"
  security_list_ids = [oci_core_security_list.publicSL.id]
}

#creates route table
resource "oci_core_route_table" "publicRT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"
  display_name   = "public_route_table"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.vcn1.id}"
  }
}

#creates the security list
resource "oci_core_security_list" "publicSL" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"
  display_name   = "public_security_list"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    tcp_options {
      max = "3389"
      min = "3389"
    }

    protocol = "6"
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    tcp_options {
      min = "5985"
      max = "5986"
    }

    protocol = "6"
    source   = "0.0.0.0/0"
  }

  #if you want to check ping options
  ingress_security_rules {
    icmp_options {
      type = "3"
      code = "4"
    }

    protocol = "1"
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    icmp_options {
      type = "8"
    }

    protocol = "1"
    source   = "0.0.0.0/0"
  }
}
