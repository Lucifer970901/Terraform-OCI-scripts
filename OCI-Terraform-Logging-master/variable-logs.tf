variable "log_display_name" {
  description = " The user-friendly display name. This must be unique within the enclosing resource, and it's changeable."
}

/*
variable "log_group_id" {
    description = "OCID of the log gtoup"
  
}
*/

variable "log_type" {
  description = "The log tye that the log object is for - whether custom or service"

}

variable "log_is_enabled" {

  description = "whether or not this resourcee is currently enabled"
}

variable "log_retention_duration" {
  description = "Log retention duration in 30 day increments (30, 60, 90 and so on until 180)"

}
variable "log_definition" {
  description = "Definition of log sources and their properties"
  type = map(object({
    resource    = string
    category    = string
    service     = string
    source_type = string
    parameters  = optional(string) # Optional field
  }))
}

