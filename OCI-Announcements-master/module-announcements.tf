module "announcements" {
  source = "./announcements"

  compartment_id = var.compartment_id
  topic_id       = var.topic_id

  announcement_subscription_display_name = var.announcement_subscription_display_name
  announcement_subscription_description  = var.announcement_subscription_description

  announcement_subscription_preferred_language  = var.announcement_subscription_preferred_language
  announcement_subscription_preferred_time_zone = var.announcement_subscription_preferred_time_zone

  use_filter    = var.use_filter
  filter_groups = var.filter_groups



  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

}