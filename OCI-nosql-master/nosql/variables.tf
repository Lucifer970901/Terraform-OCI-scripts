

variable "compartment_id" {
  description = "The OCID of the compartment"
  type        = string
}
variable "table_definitions" {
  description = "Map of table names and DDL statements"
  type        = map(object({
    statement  = string
    table_name = string
  }))
}



variable "max_read_units" {
  description = "The maximum read units"
  type        = number
  default     = 50
}

variable "max_write_units" {
  description = "The maximum write units"
  type        = number
  default     = 50
}

variable "max_storage_in_gbs" {
  description = "The maximum storage in gigabytes"
  type        = number
  default     = 20
}
variable "is_auto_reclaimable" {
  description = "True if table can be reclaimed after an idle period."
  type = bool
  default = false
  
}
variable "capacity_mode" {
  description = "The capacity mode of the table. If capacityMode = ON_DEMAND, maxReadUnits and maxWriteUnits are not used, and both will have the value of zero. "
  default = "PROVISIONED"
  
}

/*
variable "freeform_tags" {
  description = "Freeform tags associated with resources."
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "Defined tags associated with resources."
  type        = map(string)
  default     = {}
}
*/