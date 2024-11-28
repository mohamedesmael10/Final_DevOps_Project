# Resource definition for EC2 instances
resource "aws_instance" "instance" {
  count                       = var.instance_count
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[count.index]
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address

  user_data = var.user_data 

  tags = {
    Name = "${var.instance_name}-${count.index}"
  }
}

# Null resource for provisioning with Ansible on private instances
# resource "null_resource" "private_instance_provisioners" {
#   count = var.associate_public_ip_address ? 0 : var.instance_count # Applies to each private instance

#   # Connection details for private instances via the bastion host
#   connection {
#     type                = "ssh"
#     user                = var.instance_user           # Use variable for user
#     private_key         = file(var.key)          # Use variable for key path
#     host                = aws_instance.instance[count.index].private_ip # Private IP of the instance
#     bastion_host        = var.bastion_public_ip       # Bastion host's public IP
#     bastion_user        = var.bastion_user            # Use variable for bastion user
#     bastion_private_key = file(var.key)          # Use variable for bastion key
#     timeout             = "3m"
#   }

#   # Provisioner to copy the Ansible directory to the private instance through the bastion host
#   provisioner "file" {
#     source      = "./ansible"              # The Ansible directory on your local machine
#     destination = "/home/ubuntu/ansible"   # Destination on the private instance
#   }

#   # Provisioner to run the script on the private instance
#   provisioner "remote-exec" {
#    inline = [
#     "chmod +x /home/ubuntu/ansible/script.sh",  # Ensure the script is executable
#     "cd /home/ubuntu/ansible",
#     "./script.sh"                                 # Run your script
#   ]
# }


#   # Ensure the instances are created before running provisioning scripts
#   depends_on = [aws_instance.instance]
# }
