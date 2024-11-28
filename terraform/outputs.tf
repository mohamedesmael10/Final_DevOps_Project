# output "internet_gateway_id" {
#   description = "The ID of the Internet Gateway."
#   value       = module.internet_gateway.internet_gateway_id
# }

# output "public_route_table_id" {
#   description = "The ID of the public Route Table."
#   value       = module.public_route_table.route_table_id
# }

# output "private_route_table_id" {
#   description = "The ID of the private Route Table."
#   value       = module.private_route_table.route_table_id
# }

# output "nat_gateway_id" {
#   description = "The ID of the NAT Gateway."
#   value       = module.nat_gateway.nat_gw_id
# }

output "bastion_public_ip_1" {
  value = module.public_instances.public_ips[0]  # Accessing the first (and only) public IP

}

output "bastion_public_ip_2" {
  value = module.public_instances.public_ips[1]  # Accessing the first (and only) public IP

}

output "public_lb_dns" {
  value = module.load_balancer.dns_name
}
