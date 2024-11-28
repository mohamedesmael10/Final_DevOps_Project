# Devops-Project

This project is a Terraform-based infrastructure setup for a DevOps environment. It includes modules for various AWS resources such as VPC, subnets, security groups, load balancers, and more. Additionally, it uses Ansible for configuration management.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed
- [Docker](https://docs.docker.com/get-docker/) installed

## Setup

1. **Clone the repository:**

    ```sh
    git clone https://github.com/AyaOmer/Devops-Project.git
    cd Devops-Project
    ```

2. **Initialize Terraform:**

    ```sh
    terraform init
    ```

3. **Review and modify `terraform.tfvars` to match your requirements:**

    ```tfvars
    project_name = "esmael"
    ami_id       = "ami-0e86e20dae9224db8"
    instance_type = "t2.micro"
    instance_name = "Terraform"
    lb_name       = "my-load-balancer"
    key_name      = "key-pair"
    user_data = <<-EOF
                  #!/bin/bash
                  sudo apt update
                  sudo apt install -y software-properties-common python3-pip
                  pip3 install ansible
                  echo "Welcome to Esmael's private_instances. Ansible has been installed." > /home/ubuntu/welcome.txt
                  EOF
    bastion_ingress_rules = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    nginx_ingress_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
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
    ```

4. **Apply the Terraform configuration:**

    ```sh
    terraform apply
    ```

    Confirm the apply with `yes`.

## Ansible Configuration

The Ansible playbook is located in the [ansible](./ansible) directory. It installs Docker and Docker Compose on the local machine.

- **Run the Ansible playbook:**

    ```sh
    cd ansible
    ./script.sh
    ```

## Docker Configuration

The `Dockerfile` is located in the [Docker](./Docker) directory. It builds and serves a React application using Nginx.

- **Build the Docker image:**

    ```sh
    docker build -t your-image-name Docker/
    ```

- **Run the Docker container:**

    ```sh
    docker run -p 80:80 your-image-name
    ```

## Outputs

The Terraform configuration provides the following outputs:

- `bastion_public_ip`: The public IP of the bastion host.

## Modules

### VPC

- **Variables:**
  - `vpc_id`: The ID of the VPC.
  - `subnet_ids`: List of subnet IDs.
  - `name`: The name of the VPC.

### Subnet

- **Variables:**
  - `vpc_id`: The VPC ID for the subnet.
  - `subnet_cidr`: The CIDR block for the subnet.
  - `availability_zone`: The availability zone for the subnet.
  - `map_public_ip_on_launch`: Boolean to map public IP on launch.
  - `subnet_name`: The name of the subnet.

- **Outputs:**
  - `subnet_id`: The ID of the created subnet.

### Security Group

- **Variables:**
  - `vpc_id`: The ID of the VPC.
  - `name`: The name of the Security Group.
  - `ingress_rules`: List of ingress rules.
  - `description`: Description of the security group.

### Key Pair

- **Variables:**
  - `encrypt_kind`: The encryption algorithm.
  - `encrypt_bits`: The number of bits for encryption.

### Load Balancer

- **Variables:**
  - `lb_name`: Name of the load balancer.
  - `internal`: Whether the load balancer is internal or not.
  - `subnet_ids`: List of subnet IDs for the load balancer.
  - `security_group_ids`: List of security group IDs for the load balancer.
  - `target_group_name`: Name of the target group.
  - `target_group_port`: Port of the target group.
  - `target_group_protocol`: Protocol of the target group.
  - `vpc_id`: VPC ID where the target group is created.
  - `listener_port`: Port for the listener.
  - `listener_protocol`: Protocol for the listener.
  - `instance_count`: Number of instances to attach to the target group.
  - `instance_ids`: List of instance IDs to attach to the target group.