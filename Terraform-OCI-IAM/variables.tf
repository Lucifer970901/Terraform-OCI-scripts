variable "tenancy_ocid"{}
variable "compartment_ocid"{}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

#declare the providers where you want to create resources
provider "oci"{
tenancy_ocid = "${var.tenancy_ocid}"
fingerprint = "${var.fingerprint}"
private_key_path = "${var.private_key_path}"
region = "${var.region}"
user_ocid = "${var.user_ocid}"
}
