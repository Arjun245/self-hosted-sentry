# aws_profile         = "terraform-user"

region              = "ap-south-2"
instance_name       = "sentry_server"
instance_type       = "t3.xlarge"
key_name            = "sentry-key"
ami_name_pattern    = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
ami_owners          = ["099720109477"] # Ubuntu images account owner
virtualization_type = "hvm"
root_volume_size    = 30
vpc_name            = "sentry-vpc"
vpc_cidr            = "172.16.0.0/24"
public_subnet_cidr  = "172.16.0.0/28"
availability_zone   = "ap-south-2a"
allowed_ports = [
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