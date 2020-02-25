variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}

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
  cidr_block     = "192.0.0.0/16"  # you can choose any other CIDR range, display name and dns label as you wish
  dns_label      = "vcn1"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "vcn1"
}

resource "oci_core_internet_gateway" "vcn1" {
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.vcn1.id}"
}

resource "oci_core_route_table" "vcn1"{
#route_table_id = "${oci_core_vcn_vcn1.route_table_id}"
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.vcn1.id}"

route_rules{
destination = "0.0.0.0/0" # this allows all the ip addresses to pass through internet gateway, you can mention if you need any particular ranges or an IP in specific
network_entity_id = "${oci_core_internet_gateway.vcn1.id}"
}
}
resource "oci_core_subnet" "publicvcn1"{
dns_label = "publicVcn1"
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.vcn1.id}"
display_name = "public_subnet_vcn1"
cidr_block = "192.0.0.0/24"  #you can choose any other cidr ranges if you want
#availability_domain = "${data.oci_ientity_availability_domains.ads.availability_domain}"
}

resource "oci_core_subnet" "privatevcn1"{
dns_label = "privateVcn1"
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_vcn.vcn1.id}"
display_name = "private_subnet_vcn1"
cidr_block = "192.0.1.0/24"
prohibit_public_ip_on_vnic = "true"
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
output "default_route_table_id"{
value = "${oci_core_route_table.vcn1.id}"
}
output "public_subnet_id"{
value = "${oci_core_subnet.publicvcn1.id}"
}
output "private_subnet_id"{
value = "${oci_core_subnet.privatevcn1.id}"
}
