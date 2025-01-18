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
  ami               = data.aws_ami.os_ami.id
  instance_type     = var.instance_type
  key_name          = var.key_name
  security_group_id = module.security_group.id
  root_volume_size  = var.root_volume_size
}

# Allocate Elastic IP for EC2
resource "aws_eip" "sentry_eip" {
  instance   = module.ec2_instance.instance_id
  depends_on = [module.ec2_instance]
}

# Security Group
module "security_group" {
  source        = "./modules/security_group"
  name          = "sentry-sg"
  allowed_ports = var.allowed_ports
}

# Ansible Inventory
resource "local_file" "inventory" {
  content = <<EOT
[${var.instance_name}]
${aws_eip.sentry_eip.public_ip} ansible_user=${var.ansible_user} ansible_private_key_file=${path.cwd}/secrets/${var.key_name}.pem
EOT

  filename        = "../ansible/inventory/hosts.ini"
  file_permission = "0644"
}