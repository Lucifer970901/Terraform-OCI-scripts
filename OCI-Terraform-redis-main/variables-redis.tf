/*
variable "db_subnet_id" {

}

*/
variable "nsg_ids" { default = [] }

variable "redis_cluster_display_name" {
  default     = null
  description = "Display name of the created redis. Defaults to redis_osdu"
  type        = string

}

variable "redis_cluster_node_count" {
  default     = 3
  description = " 1 Primary node and 2 Replicas"
  type        = number
}

variable "redis_cluster_node_memory_in_gbs" {
  default     = 16
  description = " The amount of memory allocated to the cluster’s nodes, in gigabytes."
  type        = number
}

variable "redis_cluster_mode" {
  default     = "NONSHARDED"
  description = "Describes if the cluster is sharded or not - SHARDED / NONSHARDED"
}
variable "redis_shard_count" {
  default     = 1
  description = "The number of shards in sharded cluster. Only applicable when clusterMode is SHARDED."
}
variable "redis_cluster_software_version" {
  default     = "REDIS_7_0"
  description = "The Oracle Cloud Infrastructure Cache engine version that the cluster is running."
  type        = string
}