module "log_group" {
  source                 = "./modules/logging/log_group"
  compartment_id         = var.compartment_id
  log_group_display_name = var.log_group_display_name
  log_group_description  = var.log_group_description

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

}


output "log_group_id" {
  value = module.log_group.log_group_id
}


