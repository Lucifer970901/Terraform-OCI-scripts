#oci providers
provider "oci" {
 tenancy_ocid = "${var.tenancy_ocid}"
 user_ocid = "${var.user_ocid}"
 fingerprint = "${var.fingerprint}"
 private_key_path = "${var.private_key_path}"
 region = "${var.region}"
}
data "oci_identity_availability_domains" "ads"{
compartment_id = "${var.tenancy_ocid}"
}

#common variables
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}

#variables related to vcn and subnets
variable "vcn_display_name" {
default = "vcn1"
}
variable "vcn_cidr_block" {
default = "192.0.0.0/16"
}
variable "subnet_cidr_block" {
default = "192.0.1.0/24"
}
variable "subnet_display_name" {
default = "publicSubnet"
}
variable "route_table_name" {
default = "public_route_table"
}
variable "security_list_name" {
default = "public_security_list"
}

#variables used for instances
variable "instance_user"{
default = "opc"
}
variable "userdata" {
  default = "userdata"
}

variable "cloudinit_ps1" {
  default = "cloudinit.ps1"
}
variable "instance_password"{
description = "the password must contain uppercase and lowercase alphabets, numbers and special characters and, must be  atleast 12 characters in length. "
}
variable "cloudinit_config" {
  default = "cloudinit.yml"
}
variable "preserve_boot_volume" {
default = false
}
variable "boot_volume_size_in_gbs" {
  default = "256"
}
variable "shape" {
  default = "VM.Standard2.1"
}
variable "assign_public_ip" {
  default = ""
}
variable "blockVolSize"{
default = "100"
}

variable "ssh_authorized_keys" {
  default = "C:Users/megn/new.pub"
}

variable "instance_name" {
  default = "TFWindows"
}
