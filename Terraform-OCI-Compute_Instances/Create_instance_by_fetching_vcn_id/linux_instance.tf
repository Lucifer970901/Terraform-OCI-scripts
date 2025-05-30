#declare  the imported vcn and subnet values
data "oci_core_vcn" "test_vcn" {
    #Required
    vcn_id = "${var.vcn_id}"
}

data "oci_core_subnet" "test_subnet" {
    #Required
    subnet_id = "${var.subnet_id}"
}

#declare the resources for linux instance
resource "oci_core_instance" "linux" {
  count               = "1"
 availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
 compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.instance_name}"
  shape               = "${var.shape}"

  create_vnic_details {
    assign_public_ip = "${var.assign_public_ip}"
    display_name   = "primaryvnic"
    hostname_label = "linuxInstance"
    subnet_id      = "${var.subnet_id}"
  }

  metadata = {
    ssh_authorized_keys = "${file("${var.ssh_public_key}")}"
  }

  source_details {
    boot_volume_size_in_gbs = "${var.boot_volume_size_in_gbs}"
    source_id               = "${var.instance_image_ocid[var.region]}"
    source_type             = "image"
  }
  timeouts {
    create = "60m"
  }
}

resource "oci_core_volume" "linux" {
availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      ="${var.compartment_ocid}"
  display_name        = "Terraform_deployed_Instance"
  size_in_gbs         = "${var.boot_volume_size_in_gbs}"
}

resource "oci_core_volume_attachment" "linux" {
  count           = "1"
  attachment_type = "iscsi"
  compartment_id  = "${var.compartment_ocid}"
  instance_id     = "${oci_core_instance.linux[count.index].id}"
  volume_id       = "${oci_core_volume.linux.id}"
  use_chap        = true
}
