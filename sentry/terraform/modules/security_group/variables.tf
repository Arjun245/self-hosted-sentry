variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "allowed_ports" {
  description = "List of allowed ingress rules"
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
    cidr      = string
  }))
}
