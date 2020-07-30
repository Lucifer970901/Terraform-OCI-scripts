output "lb_public_ip" {
  value = ["${oci_load_balancer.CreateLoadBalancer.ip_addresses}"]
}
