#define oci provider configuaration
provider "oci"{
    tenancy_ocid = "${var.tenancy_ocid}"
    user_ocid = "${var.user_ocid}"
    region ="${var.region}"
    private_key_path = "${var.private_key_path}"
    fingerprint = "${var.fingerprint}"
}

#provide the list of availability domain
data "oci_identity_availability_domain" "ad" {
  compartment_id = "${var.compartment_ocid}"
  ad_number = "${var.availability_domain}"
}
#common variables
variable "tenancy_ocid"{}
variable "user_ocid"{}
variable "private_key_path"{}
variable "fingerprint"{}
variable "region"{}
variable "compartment_ocid"{}
variable "availability_domain"{
default = "1"
}

#variables to define vcn
variable "vcn_cidr_block"{
description = "provide the valid IPV4 cidr block for vcn"
}
variable "vcn_dns_label" {
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet. "
  default     = "vcn"
}
variable "vcn_display_name" {
description = "provide a display name for vcn"
}


#variables to define the public subnet
variable "cidr_block_publicsubnet"{
description = "note that the cidr block for the subnet must be smaller and part of the vcn cidr block"
}

variable "publicSubnet_dns_label" {
description = "A DNS label prefix for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet. "
  default     = "publicsubnet"
}
variable "display_name_publicsubnet"{
description = "privide a displayname for public subnet"
}


#variables to create linux instance
variable instance_linuximage_ocid {
  type = "map"

  default = {
    # Updated to Oracle Linux 7.8 with all patches as of April 2020.

    ap-sydney-1 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaao3vineoljixw657cxmbemwasdgirfy6yfgaljqsvy2dq7wzj2l4q"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaahjkmmew2pjrcpylaf6zdddtom6xjnazwptervti35keqd4fdylca"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaav3isrmykdh6r3dwicrdgpmfdv3fb3jydgh4zqpgm6yr5x3somuza"
    ap-mumbai-1  = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaanwfcq3baulkm73kcimzymx7qgfpoja2b56wgwhopjjgrz4om67zq"
  }
}

variable "linux_instance_name"{
description  = "provide the display name for thelinux instance to be deployed"
}

variable "ssh_authorized_keys" {
  default = "id_rsa.pub"
}

variable "preserve_boot_volume_for_linux" {
  default = false
}
variable "boot_volume_size_in_gbs_for_linux" {
  default = "50"
}
variable "linux_shape" {
  default = "VM.Standard2.1"
}
variable "assign_public_ip_for_linux" {
  default = true
}

#variables to create windows instance
variable "windows_instance_name"{
description  = "provide the display name for the windows instance to be deployed"
}
variable "instance_user"{
default = "opc"
}
variable "instance_password"{
description ="provide the password for login to the windows instance as 'opc' user."
}

variable "preserve_boot_volume_for_windows" {
  default = false
}
variable "boot_volume_size_in_gbs_for_windows" {
  default = "256"
}
variable "windows_shape" {
  default = "VM.Standard2.1"
}
variable "assign_public_ip_for_windows" {
  default = true
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

#import the oci provided images
data "oci_core_images" "OLImageOCID-ol7" {
  compartment_id           = "${var.compartment_ocid}"
  operating_system         = "Windows"
  operating_system_version = "Server 2016 Standard"

  # exclude GPU specific images
  filter {
    name   = "display_name"
    values = ["^Windows-Server-2016-Standard-Edition-VM-Gen2-([\\.0-9-]+)$"]
    regex  = true
  }
}


variable instance_windowsimage_ocid {
  type = "map"

  default = {
    # Images released in and after July 2018 have cloudbase-init and winrm enabled by default, refer to the release notes - https://docs.cloud.oracle.com/iaas/images/
    # Image OCIDs for Windows-Server-2012-R2-Standard-Edition-VM-Gen2-2018.10.12-0 - https://docs.cloud.oracle.com/iaas/images/image/80b70ffd-5efc-479e-872c-d1bf6bcbefbd/
    ap-sydney-1 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaa2qj2ijkwf4y6tiou736kyl44lspdlv2wnotmbns6vprhv3pxsr2q"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaaxgzzrdoge7zxrjtmjqjhicaxsujljvaju3mbwryo5x5k5axlmsza"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaaskz7sq3mlmiwazehuqzoxdq4xz7sinrwn5m6kedxz3td2c7it2vq"
  }
}
