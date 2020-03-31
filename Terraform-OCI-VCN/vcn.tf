#This file contains A vcn with public and private subnets and associated route tables and security lists for each of the subnets configured
#This contains all the resources, main and outout files in a single file.
#among these if you want to deploy any of the vcn in any other region just define the variable and while doing "terraform apply" 
#you can give the particular value or the name required.
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "cidr_block_vcn"{}
variable "display_name_vcn"{}


provider "oci" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region           = "${var.region}"
}
# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.tenancy_ocid}"
}
#declare the resources to be deployed
resource "oci_core_vcn" "vcn1" {
  cidr_block     = "${var.cidr_block_vcn}"
  dns_label      = "vcn1"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.display_name_vcn}"
}
resource "oci_core_internet_gateway" "vcn1" {
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.vcn1.id}"
}

resource "oci_core_subnet" "publicvcn1"{
dns_label = "publicVcn1"
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.vcn1.id}"
display_name = "${var.display_name_subnet1}"
cidr_block = "${var.cidr_block_subnet1}"
route_table_id = "${oci_core_route_table.publicRT.id}"
security_list_ids = ["${oci_core_security_list.publicSL.id}"]
}

resource "oci_core_route_table" "publicRT"{
 compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.vcn1.id}"
display_name = "public_route_table"

route_rules{
destination = "0.0.0.0/0"
network_entity_id = "${oci_core_internet_gateway.vcn1.id}"
}
 
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
      max = "22"
      min = "22"
    }

    protocol = "6"
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    icmp_options {
      type = "0"
    }

    protocol = "1"
    source   = "0.0.0.0/0"
  }
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
  
resource "oci_core_subnet" "privatevcn1"{
dns_label = "privatevcn1"
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.vcn1.id}"
display_name = "${var.display_name_subnet2}"
cidr_block = "${var.cidr_block_subnet2}"
prohibit_public_ip_on_vnic = "true"
route_table_id = "${oci_core_route_table.privateRT.id}"
security_list_ids = ["${oci_core_security_list.privateSL.id}"]
}

}
resource "oci_core_route_table" "privateRT"{
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.vcn1.id}"
display_name = "private_route_table"
}



resource "oci_core_security_list" "privateSL" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"
  display_name   = "private_security_list"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    tcp_options {
      max = "22"
      min = "22"
    }

    protocol = "6"
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    icmp_options {
      type = "0"
    }

    protocol = "1"
    source   = "0.0.0.0/0"
  }
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

#output the results
output "vcn_id" {
  value = "${oci_core_vcn.vcn1.id}"
}
output "internet_gateway_id"{
value = "${oci_core_internet_gateway.vcn1.id}"
}
output "show-ads" {
  value = "${data.oci_identity_availability_domains.ads.availability_domains}"
}
output "public_route_table_id"{
value = "${oci_core_route_table.publicRT.id}"
}
output "private_route_table_id"{
value = "${oci_core_route_table.privateRT.id}"
}

output "public_subnet_id"{
value = "${oci_core_subnet.publicvcn1.id}"
}
