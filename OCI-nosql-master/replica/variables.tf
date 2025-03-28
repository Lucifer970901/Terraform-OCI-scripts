
variable "compartment_id" {
  description = "The OCID of the compartment"
  type        = string
}

variable "replica_max_read_units" {
  description = "The maximum read units"
  type        = number
  default     = 50
}

variable "replica_max_write_units" {
  description = "The maximum write units"
  type        = number
  default     = 50
}

variable "replica_region" {
    description = "The region to be replicated"
  
}


variable "table_ids" {
  description = "Map of table names to table IDs"
  type        = map(string)
}
