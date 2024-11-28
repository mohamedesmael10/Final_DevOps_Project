# Define the VPC
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "my-vpc-Terraform"
}

# Public Subnets
module "public_subnet_1" {
  source                = "./modules/subnet"
  vpc_id                = module.vpc.vpc_id
  subnet_cidr           = "10.0.1.0/24"
  availability_zone     = "us-east-1a"
  map_public_ip_on_launch = true
  subnet_name           = "public-subnet-1"
  depends_on            = [module.vpc]
}

module "public_subnet_2" {
  source                = "./modules/subnet"
  vpc_id                = module.vpc.vpc_id
  subnet_cidr           = "10.0.3.0/24"
  availability_zone     = "us-east-1b"
  map_public_ip_on_launch = true
  subnet_name           = "public-subnet-2"
  depends_on            = [module.vpc]
}


# Internet Gateway
module "internet_gateway" {
  source     = "./modules/internet_gateway"
  vpc_id     = module.vpc.vpc_id
  name       = "${var.project_name}-igw"
  depends_on = [module.vpc]
}

# Public Route Table
module "public_route_table" {
  source              = "./modules/public_route_table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  subnet_ids          = [module.public_subnet_1.subnet_id,module.public_subnet_2.subnet_id]
  name                = "${var.project_name}-public-rt"
  depends_on          = [module.vpc, module.internet_gateway, module.public_subnet_1]
}



# Security Groups
module "bastion_security_group" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc.vpc_id
  name          = "${var.project_name}-bastion-sg"
  description   = "Security group for Bastion host"
  ingress_rules = var.bastion_ingress_rules
  depends_on    = [module.vpc]
}

module "nginx_security_group" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc.vpc_id
  name          = "${var.project_name}-nginx-sg"
  description   = "Security group for Nginx"
  ingress_rules = var.nginx_ingress_rules
  depends_on    = [module.vpc]
}

module "jenkins_portainer_sg" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc.vpc_id
  name          = "${var.project_name}-jenkins-portainer-sg"
  description   = "Security group for Jenkins and Portainer"
  ingress_rules = var.custom_ingress_rules
  depends_on    = [module.vpc]
}

# Public Instances
module "public_instances" {
  source                      = "./modules/instance"
  instance_count               = 2
  ami_id                       = var.ami_id
  associate_public_ip_address  = true
  instance_type                = var.instance_type
  subnet_ids                   = [module.public_subnet_1.subnet_id,module.public_subnet_2.subnet_id]
  security_group_ids           = [
    module.nginx_security_group.security_group_id, 
    module.jenkins_portainer_sg.security_group_id, 
    module.bastion_security_group.security_group_id
  ]
  key_name                     = var.key_name
  instance_name                = "public"
  depends_on      = [module.public_subnet_1, module.nginx_security_group, module.bastion_security_group]
}


module "load_balancer" {
  source                = "./modules/load_balancer"
  lb_name               = "my-load-balancer"
  internal              = false
  subnet_ids            = [module.public_subnet_1.subnet_id,module.public_subnet_2.subnet_id]
  security_group_ids    = [
    module.nginx_security_group.security_group_id, 
    module.jenkins_portainer_sg.security_group_id, 
    module.bastion_security_group.security_group_id
  ]
  target_group_name     = "my-target-group"
  target_group_port     = 3000  # Updated port to 3000 to match Docker configuration
  
  target_group_protocol = "HTTP"
  vpc_id                = module.vpc.vpc_id
  listener_port         = 3000  # Updated port to 3000 for the load balancer listener
  
  listener_protocol     = "HTTP"
  instance_count        = 2
  instance_ids          = module.public_instances.instance_ids

  depends_on = [
    module.nginx_security_group,
    module.public_subnet_1,
  ]
}


# Key Pair
module "key" {
  source       = "./modules/key_pair"
 key_name = var.key_name
  depends_on   = [module.vpc]
}


# module "ansible_provisioning" {
#   source          = "./modules/ansible"
#   instance_ips    = module.private_instances.private_ips  
#   ansible_user    = "ubuntu"
#   bastion_user    = "ubuntu"   
#   private_key_path = "./key-pair.pem"  
#   playbook_path   = "./ansible/playbook.yml"  
#   bastion_public_ip = module.public_instances.public_ips[0]
#   depends_on      = [module.private_subnet_1, module.private_subnet_2, module.key , module.public_instances , module.private_instances , module.nat_gateway , module.jenkins_portainer_sg , module.nginx_security_group , module.bastion_security_group]

# }
