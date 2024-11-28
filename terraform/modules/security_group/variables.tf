variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "name" {
  description = "The name of the Security Group."
  type        = string
}


variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = ""  # Optional default value
}
