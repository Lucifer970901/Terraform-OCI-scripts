resource "oci_logging_log" "test_log" {
   
    #Required
    display_name ="${var.log_display_name}-${each.key}"
    log_group_id = var.log_group_id
    log_type = var.log_type

    for_each = var.log_definition

    #Optional
    configuration {
        #Required
        source {
            #Required
            category    = each.value.category
            resource    = each.value.resource
            service     = each.value.service
            source_type = each.value.source_type
            /*

             parameters = lookup(each.value.source, "parameters", null)
            category = var.log_configuration_source_category
            resource = var.log_configuration_source_resource
            service = var.log_configuration_source_service
            source_type = var.log_configuration_source_type

            #Optional
            parameters = var.log_configuration_source_parameters
            */
        }

        #Optional
        compartment_id = var.compartment_id
    }
   
    is_enabled = var.log_is_enabled
    retention_duration = var.log_retention_duration

/*
    defined_tags = var.defined_tags
    freeform_tags = var.freeform_tags
    */
}