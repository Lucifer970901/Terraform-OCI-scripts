
resource "oci_redis_redis_cluster" "redis_cluster" {
    compartment_id = var.compartment_id
    display_name = var.redis_cluster_display_name
    node_count = var.redis_cluster_node_count
    node_memory_in_gbs = var.redis_cluster_node_memory_in_gbs
    software_version = var.redis_cluster_software_version
    subnet_id = var.subnet_id
    cluster_mode = var.redis_cluster_mode
    #shard_count  = var.redis_shard_count # only applicable to cluster with cluster mode of SHARDED
    nsg_ids = var.nsg_ids
  
  # Optional
  #defined_tags     = var.defined_tags
  #freeform_tags    = var.freeform_tags
  

  }




