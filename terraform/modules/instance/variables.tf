variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1  # Default number of instances to create
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"  # Common default instance type
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instances"
  type        = list(string)
}

variable "key_name" {
  description = "Key name for the EC2 instances"
  type        = string
}

variable "user_data" {
  description = "User data to initialize the EC2 instances"
  type        = string
  default     = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install -y nginx
                sudo systemctl enable --now nginx
               
                sudo systemctl restart nginx
                # Create a sample index.html file
                echo "Terraform project From Private ec2<br><br>created By: Aya Omar<br><br>The HostName: $(hostname) " | sudo tee /var/www/html/index.html
                EOF
}

variable "instance_name" {
  description = "Base name for the EC2 instances"
  type        = string
  default     = "my-instance"  # Default base name for convenience
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instances."
  type        = bool
  default     = false  # Default is no public IP
}

variable "key" {
  description = "Path to the private key file"
  type        = string
  default     = "./key-pair.pem"  # Default path to the private key
}

variable "key_path" {
  description = "Path to the private key file"
  type        = string
  default     = "./key-pair.pem"  # Default key path
}

variable "instance_user" {
  description = "SSH user for the EC2 instances"
  type        = string
  default     = "ubuntu"  # Default user for EC2 instances
}

variable "bastion_user" {
  description = "SSH user for the bastion host"
  type        = string
  default     = "ubuntu"  # Default user for bastion, can be modified
}

variable "bastion_public_ip" {
  description = "Public IP address of the bastion host for SSH access to private instances"
  type        = string
  default     = ""  # Default is empty, making it optional
}

variable "ansible_source_directory" {
  description = "Path to Ansible files"
  type        = string
  default     = "./ansible"  # Default path for Ansible files
}
