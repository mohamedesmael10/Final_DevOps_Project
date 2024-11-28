project_name = "esmael"
# ami_id       = "ami-0e86e20dae9224db8" 
ami_id       ="ami-0866a3c8686eaeeba"  

instance_type = "t2.micro"
instance_name = "Terraform"
lb_name       = "my-load-balancer"
key_name      = "key-pair" 

user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install -y nginx
                sudo systemctl enable --now nginx
               
                sudo systemctl restart nginx
                # Create a sample index.html file
                echo "Terraform project From Private ec2<br><br>created By: Aya Omar<br><br>The HostName: $(hostname) " | sudo tee /var/www/html/index.html
               EOF


# Ingress rules for various security groups

# user_data = <<-EOF
#               #!/bin/bash
#               # Update the package index
#               sudo apt update
              
#               # Install Ansible and its dependencies
#               sudo apt install -y software-properties-common python3-pip

#               # Install Ansible using pip
#               pip3 install ansible

#               # Print a welcome message
#               echo "Welcome to Esmael's private_instances. Ansible has been installed." > /home/ubuntu/welcome.txt
#               EOF


bastion_ingress_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Bastion access
  }
]

nginx_ingress_rules = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access
  }
]

custom_ingress_rules = [
  {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 8084
    to_port     = 8084
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
