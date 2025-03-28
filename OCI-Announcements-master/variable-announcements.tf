# Required Variables

variable "announcement_subscription_display_name" {
  description = "A user-friendly name for the announcement subscription. Does not have to be unique and is changeable."
  type        = string
}

variable "announcement_subscription_description" {
  description = "A description for the announcement subscription. Avoid entering confidential information."
  type        = string
}

variable "topic_id" {
  description = "The OCID of the Notifications service topic that is the target for publishing announcements that match the configured subscription."
  type        = string
}

# Optional Variables

variable "announcement_subscription_preferred_time_zone" {
  description = "The time zone in which the user prefers to receive announcements. Use IANA time zone format (e.g., 'Asia/Kolkata' for IST)."
  type        = string
  default     = "Asia/Kolkata"
}

variable "announcement_subscription_preferred_language" {
  description = "Preferred language for announcements (e.g., en-US)."
  type        = string
  default     = "en-US"
}



################################################################################
#   Filter group variables
################################################################################

# Filter Group Variables
variable "use_filter" {
  default = false
}

variable "filter_groups" {
  description = "filter groups for the announcement subscription"
  type = list(object({
    name = string
    filters = list(object({
      type  = string
      value = string
    }))
  }))
  default = []
}

/*
variable "defined_tags" {
  description = "Defined tags for the announcement subscription. Each key is predefined and scoped to a namespace. Example: {\"foo-namespace.bar-key\": \"value\"}"
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Simple key-value pair that is applied without any predefined name, type, or scope."
  type        = map(string)
  default     = {}
}
*/