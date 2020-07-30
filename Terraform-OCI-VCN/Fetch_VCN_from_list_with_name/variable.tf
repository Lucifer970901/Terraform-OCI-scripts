#define oci provider configuaration
provider "oci"{
    tenancy_ocid = "${var.tenancy_ocid}"
    user_ocid = "${var.user_ocid}"
    region ="${var.region}"
    private_key_path = "${var.private_key_path}"
    fingerprint = "${var.fingerprint}"
}
#common variables
variable "tenancy_ocid"{}
variable "user_ocid"{}
variable "private_key_path"{}
variable "fingerprint"{}
variable "region"{}
variable "compartment_ocid"{}

variable "vcn_display_name" {
default = "VCN_for_terraform"
}
