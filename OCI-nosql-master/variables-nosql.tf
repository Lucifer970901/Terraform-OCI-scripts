variable "hybrid_table_name" {

}
variable "schemaless_table_name" {

}


variable "table_limits_max_read_units" {
  description = "The maximum read units for the NoSQL table"
  type        = number
  default     = 50
}

variable "table_limits_max_write_units" {
  description = "The maximum write units for the NoSQL table"
  type        = number
  default     = 50
}

variable "table_limits_max_storage_in_gbs" {
  description = "The maximum storage in gigabytes for the NoSQL table"
  type        = number
  default     = 20
}
variable "is_auto_reclaimable" {
  description = "True if table can be reclaimed after an idle period."
  type        = bool
  default     = false

}
variable "capacity_mode" {
  description = "The capacity mode of the table. If capacityMode = ON_DEMAND, maxReadUnits and maxWriteUnits are not used, and both will have the value of zero. "
  default     = "PROVISIONED"

}