# Fetch the most recent Ubuntu AMI based on name pattern and virtualization type
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_pattern]
  }

  filter {
    name   = "virtualization-type"
    values = [var.virtualization_type]
  }

  owners = var.ami_owners
}