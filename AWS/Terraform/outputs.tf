output "ec2_public_ip" {
  description = "EC2 Public IP Address"
  value       = aws_instance.web_server.public_ip
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web_server.id
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}