#!/bin/bash

# Extract EC2 public IP using Terraform
ec2_ip=$(terraform output -raw bastion_public_ip_1)
ec2_ip_2=$(terraform output -raw bastion_public_ip_2)
# Check if IP address is valid
if [ -n "$ec2_ip" ]; then
  # Write the IP to the Ansible inventory
  echo -e "[web]\n$ec2_ip" > ../ansible/inventory
  echo -e "$ec2_ip_2" >> ../ansible/inventory
fi

