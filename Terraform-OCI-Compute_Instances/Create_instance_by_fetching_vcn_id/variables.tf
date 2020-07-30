#define oci provider configuaration
provider "oci"{
    tenancy_ocid = "${var.tenancy_ocid}"
    user_ocid = "${var.user_ocid}"
    region ="${var.region}"
    private_key_path = "${var.private_key_path}"
    fingerprint = "${var.fingerprint}"
}

#provide the list of availability domain
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.compartment_ocid}"
#  ad_number = "${var.availability_domain}"
}
#common variables
variable "tenancy_ocid"{}
variable "user_ocid"{}
variable "private_key_path"{}
variable "fingerprint"{}
variable "region"{}
variable "compartment_ocid"{}

#variables to define vcn
variable "vcn_id" {
description = "provide a ocid for vcn"
default = "ocid1.vcn.oc1.iad.amaaaaaazxsy2naavsv57gnbzxpzvfzxwi7k5xxhdlq3pep7igd7ku5s4lpq"
}

#variables to define the public subnet
variable "subnet_id"{
description = "privide a ocid for public subnet"
default = "ocid1.subnet.oc1.iad.aaaaaaaa55etmrr3fzy3uac72d3pdenywmirfg2otybkdh67ognk3abl6cta"
}


#variables to create linux instance
variable instance_image_ocid {
  type = "map"

  default = {
    # Updated to Oracle Linux 7.8 with all patches as of April 2020.

    ap-sydney-1 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaao3vineoljixw657cxmbemwasdgirfy6yfgaljqsvy2dq7wzj2l4q"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaahjkmmew2pjrcpylaf6zdddtom6xjnazwptervti35keqd4fdylca"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaav3isrmykdh6r3dwicrdgpmfdv3fb3jydgh4zqpgm6yr5x3somuza"
    ap-mumbai-1  = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaanwfcq3baulkm73kcimzymx7qgfpoja2b56wgwhopjjgrz4om67zq"
  }
}

variable "instance_name"{
description  = "provide the display name for thelinux instance to be deployed"
}

variable "ssh_public_key" {
  default = "C:/Users/megn/new.pub"
}

variable "preserve_boot_volume" {
  default = false
}
variable "boot_volume_size_in_gbs" {
  default = "50"
}
variable "shape" {
  default = "VM.Standard2.1"
}
variable "assign_public_ip" {
  default = true
}
