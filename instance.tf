#This file contains the configuaration file for the instance that will be created within the VCN 
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
  default = ""
}

variable "host_name_label" {
}

variable "ssh_public_key" {
  default = "/home/opc/.ssh/id_rsa.pub"
}

variable "source_ocid" {
}

variable "subnet_ocid" {
}

#declare the resources

resource "oci_core_instance" "this" {
  count               = "1"
  availability_domain = "eLhE:AP-MUMBAI-1-AD-1"
  compartment_id      = var.compartment_ocid
  display_name        = "WebServerInstance"
  shape               = "VM.Standard2.1"

  create_vnic_details {
    assign_public_ip = true

    display_name   = "primaryvnic"
    hostname_label = "InstanceWebServer"
    subnet_id      = oci_core_subnet.this.id
  }
  metadata = {
    ssh_public_key = var.ssh_public_key
    user_data      = base64encode(var.user_data)
  }
  source_details {
    boot_volume_size_in_gbs = "50"
    source_id               = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaaka7f3qhfuobx2s7dqfgbcx5klllh5xlflbgzb5pymqsnuphehk2a"
    source_type             = "image"
  }
  timeouts {
    create = "60m"
  }
}

resource "oci_core_volume" "this" {
  availability_domain = "eLhE:AP-MUMBAI-1-AD-1"
  compartment_id      = var.compartment_ocid
  display_name        = "WebServerInstance"
  size_in_gbs         = "50"
}

resource "oci_core_volume_attachment" "this" {
  count           = "1"
  attachment_type = "iscsi"
  compartment_id  = var.compartment_ocid
  instance_id     = oci_core_instance.this[count.index].id
  volume_id       = oci_core_volume.this.id
  use_chap        = true
}


# outputs
output "instance_id" {
  description = "ocid of created instances. "
  value       = oci_core_instance.this.*.id
}

#output "private_ip" {
# description = "Private IPs of created instances. "
# value       = "${oci_core_instance.this.*.private_ip}"
#}

output "assign_public_ip" {
  description = "Public IPs of created instances. "
  value       = oci_core_instance.this.*.public_ip
}
