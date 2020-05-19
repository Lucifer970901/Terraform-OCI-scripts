#data source to be rendered from template
data "template_file" "cloudinit_ps1" {
  vars = {
    instance_name     = "${var.instance_name}"
    instance_user = "opc"
    instance_password = "${var.instance_password}"
  }

  template = "${file("${var.userdata}/${var.cloudinit_ps1}")}"
}

data "template_cloudinit_config" "cloudinit_config" {
  gzip          = false
  base64_encode = true

  # The cloudinit.ps1 uses the #ps1_sysnative to update the instance password and configure winrm for https traffic
  part {
    filename     = "cloudinit.ps1"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.cloudinit_ps1.rendered}"
  }

  # The cloudinit.yml uses the #cloud-config to write files remotely into the instance, this is executed as part of instance setup
  part {
    filename     = "cloudinit.yml"
    content_type = "text/cloud-config"
    content      = "${file("${var.userdata}/${var.cloudinit_config}")}"
  }
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


variable instance_image_ocid {
  type = "map"

  default = {
    # Images released in and after July 2018 have cloudbase-init and winrm enabled by default, refer to the release notes - https://docs.cloud.oracle.com/iaas/images/
    # Image OCIDs for Windows-Server-2012-R2-Standard-Edition-VM-Gen2-2018.10.12-0 - https://docs.cloud.oracle.com/iaas/images/image/80b70ffd-5efc-479e-872c-d1bf6bcbefbd/
    ap-sydney-1 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaa2qj2ijkwf4y6tiou736kyl44lspdlv2wnotmbns6vprhv3pxsr2q"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaaxgzzrdoge7zxrjtmjqjhicaxsujljvaju3mbwryo5x5k5axlmsza"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaaskz7sq3mlmiwazehuqzoxdq4xz7sinrwn5m6kedxz3td2c7it2vq"
  }
}

#declare the resources for creating windows instance
resource "oci_core_instance" "this" {
  count               = "1"
 availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")}"
 compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.instance_name}"
  shape               = "VM.Standard2.1"

  create_vnic_details {
    assign_public_ip = true
    display_name   = "primaryvnic"
    hostname_label = "Instance2"
    subnet_id      = "${oci_core_subnet.publicsubnet.id}"
  }
  metadata = {
    # Base64 encoded YAML based user_data to be passed to cloud-init
  #  user_data = "${data.template_cloudinit_config.cloudinit_config.rendered}"
  }

  source_details {
    boot_volume_size_in_gbs = "256"
  source_id               = "${data.oci_core_images.OLImageOCID-ol7.images.0.id}"
    source_type             = "image"
  }
  timeouts {
    create = "60m"
  }
}

resource "oci_core_volume" "this" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")}"
  compartment_id      ="${ var.compartment_ocid}"
  display_name        = "Terraform_deployed_Instance"
  size_in_gbs         = "256"
}

resource "oci_core_volume_attachment" "this" {
  count           = "1"
  attachment_type = "iscsi"
  compartment_id  = "${var.compartment_ocid}"
  instance_id     = "${oci_core_instance.this[count.index].id}"
  volume_id       = "${oci_core_volume.this.id}"
  use_chap        = true
}
