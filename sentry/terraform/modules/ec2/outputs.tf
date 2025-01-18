output "instance_id" {
  value = aws_instance.sentry_instance.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.sentry_instance.public_ip
}