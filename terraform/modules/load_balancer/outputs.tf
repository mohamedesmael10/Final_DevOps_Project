output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.lb.dns_name
}