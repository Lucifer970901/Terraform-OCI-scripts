resource "oci_announcements_service_announcement_subscription" "this" {
    #Required
    compartment_id = var.compartment_id
    display_name = var.announcement_subscription_display_name
    ons_topic_id = var.topic_id

    #Optional
   
    description = var.announcement_subscription_description

    preferred_language = var.announcement_subscription_preferred_language
    preferred_time_zone = var.announcement_subscription_preferred_time_zone

    #freeform_tags = {"bar-key"= "value"}
    #defined_tags = {"foo-namespace.bar-key"= "value"}
}
