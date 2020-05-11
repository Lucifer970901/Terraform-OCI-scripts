#oci providers
provider "oci" {
 tenancy_ocid = "${var.tenancy_ocid}"
 user_ocid = "${var.user_ocid}"
 fingerprint = "${var.fingerprint}"
 private_key_path = "${var.private_key_path}"
 region = "${var.region}"
}
#common variables

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "availability_domain"{
default ="2"
}

#variables related to vault and keys
variable "vault_id" {}
variable "key_id" {}
variable "vault_display_name"{
default = "secret_vault1"
}

variable "vault_vault_type"{
default = "DEFAULT"
}

variable "key_display_name"{
default = "secret_key3"
}
variable "key_shape_algorithm"{
default = "AES"
}

variable  "key_shape_length"{
default = "32"
}

variable "management_endpoint"{
}

variable "crypto_endpoint"{
}

variable "generated_key_include_plaintext_key"{
default = true
}

#variables used for instances
variable "ansible_User"{
default = "ansible"
}
variable "ansible_password"{
description = "the password must contain uppercase and lowercase alphabets, numbers and special characters and, must be  atleast 12 characters in length. "
}
variable "instance_user"{
default = "opc"
}
variable "instance_password"{
description = "the password must contain uppercase and lowercase alphabets, numbers and special characters and, must be  atleast 12 characters in length. "
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
  default = "C:Users/megn/.ssh/id_rsa.pub"
}

variable "instance_name" {
  default = "TFWindows"
}
variable "userdata" {
  default = "userdata"
}

variable "cloudinit_ps1" {
  default = "cloudinit.ps1"
}

variable "cloudinit_config" {
  default = "cloudinit.yml"
}
