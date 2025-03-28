resource "oci_logging_log_group" "test_log_group" {
    #Required
    compartment_id = var.compartment_id
    display_name = var.log_group_display_name

    description = var.log_group_description

/*
    #Optional
    defined_tags = var.defined_tags
    freeform_tags = var.freeform_tags

    */
   
   
}