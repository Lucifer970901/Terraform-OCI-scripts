
module "bucket_logs" {
  depends_on             = [module.log_group]
  source                 = "./modules/logging/logs"
  compartment_id         = var.compartment_id
  log_display_name       = var.log_display_name
  log_group_id           = module.log_group.log_group_id
  log_type               = var.log_type
  log_is_enabled         = var.log_is_enabled
  log_retention_duration = var.log_retention_duration
  log_definition         = var.log_definition


  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}



/*
    
    log_configuration_source_service = var.log_configuration_source_service
    log_configuration_source_type = var.log_configuration_source_type

    log_configuration_source_category = var.log_configuration_source_category
    log_configuration_source_parameters = var.log_configuration_source_parameters
    log_configuration_source_resource = var.log_configuration_source_resource
  
  */


