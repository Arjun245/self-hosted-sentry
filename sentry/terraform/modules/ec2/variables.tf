variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the instance."
  type        = string
}

variable "instance_name" {
  description = "EC2 instance Name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to attach to the EC2 instance"
  type        = string
}

variable "root_volume_size" {
  description = "Size of the root EBS volume"
  type        = number
  default     = 30
}