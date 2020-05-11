#data source to be rendered from template
data "template_file" "cloudinit_ps1" {
  vars = {
  instance_name     = "${var.windows_instance_name}"
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
#declare the resources for creating windows instance
resource "oci_core_instance" "windows" {
  count               = "1"# count indicates the number of instances to be deployed
 availability_domain = "${data.oci_identity_availability_domain.ad.name}"
 compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.windows_instance_name}"
  shape               = "${var.windows_shape}"

  create_vnic_details {
    assign_public_ip = "${var.assign_public_ip_for_windows}"
    display_name   = "primaryvnic"
    hostname_label = "WindowsInstance"
    subnet_id      = "${oci_core_subnet.publicsubnet.id}"
  }

  metadata = {
    # Base64 encoded YAML based user_data to be passed to cloud-init
    user_data = "${data.template_cloudinit_config.cloudinit_config.rendered}"
  }

  source_details {
    boot_volume_size_in_gbs = "${var.boot_volume_size_in_gbs_for_windows}"
  source_id               = "${data.oci_core_images.OLImageOCID-ol7.images.0.id}"
    source_type             = "image"
  }
  timeouts {
    create = "60m"
  }
}

resource "oci_core_volume" "windows" {
  availability_domain = "${data.oci_identity_availability_domain.ad.name}"
  compartment_id      ="${ var.compartment_ocid}"
  display_name        = "Terraform_deployed_Instance"
  size_in_gbs         = "${var.boot_volume_size_in_gbs_for_windows}"
}

resource "oci_core_volume_attachment" "windows" {
  count           = "1" #indicates the number of volumes to be attached to the instance.
  attachment_type = "iscsi"
  compartment_id  = "${var.compartment_ocid}"
  instance_id     = "${oci_core_instance.windows[count.index].id}"
  volume_id       = "${oci_core_volume.windows.id}"
  use_chap        = true
}
