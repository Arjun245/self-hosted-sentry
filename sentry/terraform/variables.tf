# variable "aws_profile" {
#   description = "AWS CLI profile to use for Terraform"
#   type        = string
#   default     = "terraform-user"
# }

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
}

# datasource variables
variable "ami_name_pattern" {
  description = "Pattern to filter AMI names."
  type        = string
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "ami_owners" {
  description = "List of owner account IDs for the AMI."
  type        = list(string)
  default     = ["211656503058"]
}

variable "virtualization_type" {
  description = "The type of virtualization for the AMI."
  type        = string
  default     = "hvm"
}

variable "ansible_user" {
  description = "The user to connect to the instance via Ansible"
  type        = string
}

# VPC Module Variables
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "sentry-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
}

variable "instance_name" {
  description = "EC2 instance Name"
  type        = string
  default     = "sentry_server"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Key name for EC2 instance"
  type        = string
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
    cidr      = string
  }))
  default = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    },
    {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    },
    {
      from_port = 9000
      to_port   = 9000
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    },
    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
  ]
}

variable "root_volume_size" {
  description = "Size of the root EBS volume"
  type        = number
}