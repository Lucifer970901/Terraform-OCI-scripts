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

#variables to define private subnet
variable "display_name_privatesubnet"{
description = "privide a displayname for private subnet"
}

variable "cidr_block_privatesubnet"{
description = "note that the cidr block for the subnet must be smaller and part of the vcn cidr block"
}

variable "privateSubnet_dns_label" {
  description = "A DNS label prefix for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet. "
  default     = "privatesubnet"
}

#variables to create linux instance
#variables to create windows instance