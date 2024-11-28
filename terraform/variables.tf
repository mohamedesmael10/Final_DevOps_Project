variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for instances."
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances."
  type        = string
}

variable "instance_name" {
  description = "Prefix for the instance names."
  type        = string
}

variable "lb_name" {
  description = "Name for the load balancer."
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access."
  type        = string
}

variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string

}

variable "bastion_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "nginx_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "custom_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}


variable "key_path" {
  description = "Path to the private key file"
  type        = string
  default     = "./key-pair.pem"  # Default key path
}
