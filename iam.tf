# This is the configuaration file for creating user, groups and related policies to create the users and give access to them globally.
#this configuaration file creates users in your tenancy and providesthe user a resource in Oracle Cloud Inrafrasturcture Identity services. 
#create the resources in your home region for it to be applied
#the configuaration file creates a user, group and adds user to the group created.
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

#create resources for new user

resource "oci_identity_user" "new_user"{
compartment_id ="${var.tenancy_ocid}"
name = "user_created_by_terraform"
description = "create a new user in my tenancy using terraform"
}
resource "oci_identity_group" "new_group"{
compartment_id = "${var.tenancy_ocid}"
name = "group_created_by_terraform"
description = "create a group in your tenancy using terraform"
}
resource "oci_identity_user_group_membership" "membership"{
user_id = "${oci_identity_user.new_user.id}"
group_id = "${oci_identity_group.new_group.id}"
}
resource "oci_identity_compartment" "compartment"{
compartment_id = "${var.compartment_ocid}"
description = "create a comparment within your oci compartment"
name = "compartment_created_using_terraform"
}

resource "oci_identity_policy" "policy"{
compartment_id = "${oci_identity_compartment.compartment.id}"
name = "policy_created_using_terraform"
statements = ["allow group group_created_by_terraform to manage all-resources in compartment compartment_created_using_terraform"]
description = "creates policies with set of statements using terraform"
}

#outputs
output "user_id"{
value = "${oci_identity_user.new_user.id}"
}
output "group_id"{
value ="${oci_identity_group.new_group.id}"
}
output "compartment_id"{
value = "${oci_identity_compartment.compartment.id}"
}
