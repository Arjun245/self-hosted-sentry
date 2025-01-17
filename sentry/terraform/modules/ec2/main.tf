resource "aws_instance" "sentry_instance" {
  ami              = var.ami
  instance_type    = var.instance_type
  key_name         = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = var.instance_name
  }
}