# Output for Elastic IP
output "sentry_elastic_ip" {
  value       = aws_eip.sentry_eip.public_ip
  description = "The public IP address of the EC2 instance with Elastic IP"
}