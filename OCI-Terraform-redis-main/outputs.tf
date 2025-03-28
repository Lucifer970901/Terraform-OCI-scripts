
output "redis_id" {
  description = "OCID of redis cluster"
  value       = try(module.redis.redis_cluster.id, null)
}

output "redis_primary_endpoint" {
  description = "The private IP address of the API endpoint for the Redis cluster's primary node."
  value       = try(module.redis.redis_cluster.primary_endpoint_ip_address, null)
}
