# Generate SSH Key Pair
resource "tls_private_key" "sentry_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Upload Public Key to AWS
resource "aws_key_pair" "sentry_key" {
  key_name   = var.key_name
  public_key = tls_private_key.sentry_key.public_key_openssh
}

# Store Private Key Locally
resource "local_file" "private_key" {
  content         = tls_private_key.sentry_key.private_key_pem
  filename        = "${path.module}/secrets/${var.key_name}.pem"
  file_permission = "0400"
}

# VPC module
module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}

# EC2 Instance Module
module "ec2_instance" {
  source            = "./modules/ec2"
  instance_name     = var.instance_name
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  key_name          = var.key_name
  security_group_id = module.security_group.id
  root_volume_size  = var.root_volume_size
}

# Allowcate Elastic IP for EC2
resource "aws_eip" "sentry_eip" {
  instance = module.ec2_instance.instance_id
}

# Security Group
module "security_group" {
  source        = "./modules/security_group"
  name          = "sentry-sg"
  allowed_ports = var.allowed_ports
}

# null_resource to update Ansible inventory after EC2 creation
resource "null_resource" "update_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      echo "[${var.instance_name}]" > ../ansible/inventory/hosts.ini
      echo "${aws_eip.sentry_eip.public_ip}" >> ../ansible/inventory/hosts.ini
    EOT
  }

  depends_on = [aws_eip.sentry_eip]
}