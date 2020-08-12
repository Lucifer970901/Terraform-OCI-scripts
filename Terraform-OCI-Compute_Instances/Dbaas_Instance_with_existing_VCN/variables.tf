// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable "region" {}
variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "private_key_path" {}
variable "fingerprint" {}
variable "cidr_bl" {default="10.1.0.0/16"}
variable "sn_cidr_bl" {default="10.1.0.0/16"}

#define oci provider configuaration
provider "oci"{
    tenancy_ocid = "${var.tenancy_ocid}"
    user_ocid = "${var.user_ocid}"
    region ="${var.region}"
    private_key_path = "${var.private_key_path}"
    fingerprint = "${var.fingerprint}"
}

# Choose an Availability Domain
#variable "availability_domain" {
#  default = "2"
#
#vcn specific
variable "vcn_display_name" {}
variable "subnet_display_name" {}
# DBSystem specific
variable "db_system_shape" {
  default = "VM.Standard2.1"
}

variable "cpu_core_count" {
  default = "1"
}

variable "db_edition" {
  default = "ENTERPRISE_EDITION"
}

variable "db_admin_password" {
  default = "BEstrO0ng_#12"
}

variable "db_name" {
  default = "aTFdb"
}

variable "db_home_db_name" {
  default = "aTFdb2"
}

variable "db_version" {
  default = "12.1.0.2"
}

variable "db_home_display_name" {
  default = "MyTFDBHome"
}

variable "db_disk_redundancy" {
  default = "HIGH"
}

variable "db_system_display_name" {
  default = "MyTFDBSystem"
}

variable "hostname" {
  default = "myoracledb"
}

variable "host_user_name" {
  default = "opc"
}

variable "n_character_set" {
  default = "AL16UTF16"
}

variable "character_set" {
  default = "AL32UTF8"
}

variable "db_workload" {
  default = "OLTP"
}

variable "pdb_name" {
  default = "pdbName"
}

variable "data_storage_size_in_gb" {
  default = "256"
}

variable "license_model" {
  default = "LICENSE_INCLUDED"
}

variable "node_count" {
  default = "1"
}

variable "data_storage_percentage" {
  default = "40"
}
