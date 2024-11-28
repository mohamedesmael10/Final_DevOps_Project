# Outputs for EC2 instances
output "instance_ids" {
  description = "The IDs of the created EC2 instances"
  value       = aws_instance.instance.*.id  # Ensure this matches your EC2 resource definition
}

output "public_ips" {
  description = "The public IPs of the created EC2 instances"
  value       = aws_instance.instance.*.public_ip  # Ensure this matches your EC2 resource definition
}

output "private_ips" {
  description = "The private IPs of the created EC2 instances"
  value       = aws_instance.instance.*.private_ip  # Ensure this matches your EC2 resource definition
}


