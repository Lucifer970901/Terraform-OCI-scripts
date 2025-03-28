
# Common
variable "compartment_id" { type = string }
#variable "state_id" { type = string }

/*
variable "redis_id" {
  type = string 
  
}

*/

variable "redis_cluster_display_name" {
    default = null
    description = "Display name of the created redis. Defaults to redis_osdu"
    type    = string
  
}

variable "redis_cluster_node_count" {
    default = 3
    description = " 1 Primary node and 2 Replicas"
    type = number
}

variable "redis_cluster_node_memory_in_gbs" {
    default = 16
    description = " The amount of memory allocated to the cluster’s nodes, in gigabytes."
    type = number
  
}

variable "redis_cluster_software_version" {
  default = "REDIS_7_0"
  description = "The Oracle Cloud Infrastructure Cache engine version that the cluster is running."
  type = string
}

variable "subnet_id" {
  description = "The subnet OCID for the Redis cluster"
  type        = string
}

variable "nsg_ids" {
  
}

variable "redis_cluster_mode"{
    default = "NONSHARDED"
    description = "Describes if the cluster is sharded or not - SHARDED / NONSHARDED"
}

variable "redis_shard_count"{
    default = 1
    description = "The number of shards in sharded cluster. Only applicable when clusterMode is SHARDED."
}
/*
variable "defined_tags" {
  description = "Defined tags for the backup."
  type        = map(string)
  default     = {}
}


variable "freeform_tags" {
  description = "Simple key-value pair applied without predefined name or scope."
  type        = map(string)
  default     = {}
}

*/