module "redis"{

    source           = "./redis" 
    compartment_id   = var.compartment_id

    #redis
    redis_cluster_display_name        = var.redis_cluster_display_name
    redis_cluster_node_count          = var.redis_cluster_node_count
    redis_cluster_node_memory_in_gbs  = var.redis_cluster_node_memory_in_gbs
    redis_cluster_software_version = var.redis_cluster_software_version
    redis_cluster_mode = var.redis_cluster_mode

    #only applicable to cluster with cluster mode of SHARDED

    #redis_shard_count = var.redis_shard_count 
   
    subnet_id = module.network.db_subnet_id
    nsg_ids = var.nsg_ids

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

}



# MQL Queries
# https://docs.oracle.com/en-us/iaas/Content/Monitoring/Reference/mql.htm
locals {
  redis_metrics = {
    "CPU Utilization" = {
      query    = format("CpuUtilization[5m]{cluster_id = \"%s\"}.percentile(0.5) > %s", module.redis.redis_id, var.cpu_utilization_alarm_threshold)
      severity = "CRITICAL"
      summary  = "CPU Utilization exceeded."
    }
    "Memory Utilization" = {
      query    = format("MemoryUtilization[5m]{cluster_id = \"%s\"}.percentile(0.5) > %s", module.redis.redis_id, var.memory_usage_alarm_threshold)
      severity = "CRITICAL"
      summary  = "Memory Utilization exceeded."
    }
    "Network Inbound Traffic" = {
      query    = format("NetworkBytesIn[5m]{cluster_id = \"%s\"}.rate() > %s", module.redis.redis_id, var.network_bandwidth_in_allowance_exceeded_alarm_threshold ) # 10MB/s
      severity = "WARNING"
      summary  = "Inbound Network Traffic exceeded threshold."
    }
    "Network Outbound Traffic" = {
      query    = format("NetworkBytesOut[5m]{cluster_id = \"%s\"}.rate() > %s", module.redis.redis_id, var.network_bandwidth_out_allowance_exceeded_alarm_threshold) # 10MB/s
      severity = "WARNING"
      summary  = "Outbound Network Traffic exceeded threshold."
    }
    "Connected Clients" = {
      query    = format("ConnectedClients[5m]{cluster_id = \"%s\"}.mean() > %s", module.redis.redis_id, var.network_connections_tracked_allowance_exceeded_alarm_threshold)
      severity = "WARNING"
      summary  = "Connected Clients exceeded."
    }
    
  }
}



module "oci_redis_monitoring" {

  for_each = local.redis_metrics

  source = "./monitoring"
  compartment_id            = var.compartment_id
  destinations              = var.destinations
  alarm_display_name = "${var.redis_cluster_display_name}-${each.key}"

  alarm_is_enabled = var.alarm_is_enabled
  alarm_metric_compartment_id     = var.compartment_id
  alarm_namespace = var.alarm_namespace
  alarm_query = each.value.query
  alarm_severity = each.value.severity

  # Optional parameters
  alarm_summary     = each.value.summary
  alarm_body         = "Alert: ${each.key} crossed threshold in Redis."
  #defined_tags      = var.alarm_defined_tags
  #freeform_tags     = var.alarm_freeform_tags
  alarm_message_format    = var.alarm_message_format
  alarm_resolution        = var.alarm_resolution
  alarm_resource_group    = var.alarm_resource_group
  alarm_pending_duration  = var.alarm_pending_duration
  alarm_suppression_enabled = var.alarm_suppression_enabled
  
  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
  
}

