output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = try(aws_lb.demo.dns_name, "")
}