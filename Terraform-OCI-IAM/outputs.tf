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
