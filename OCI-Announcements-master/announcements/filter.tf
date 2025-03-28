resource "oci_announcements_service_announcement_subscriptions_filter_group" "announcement_filter_group" {
    count = var.use_filter? length(var.filter_groups) : 0


  announcement_subscription_id = oci_announcements_service_announcement_subscription.this.id

  dynamic "filters" {
    for_each = var.filter_groups[count.index].filters
    content {
      type  = filters.value.type
      value = filters.value.value
    }
  }
  name = var.filter_groups[count.index].name

  #name = var.announcement_subscriptions_filter_group_name
}
