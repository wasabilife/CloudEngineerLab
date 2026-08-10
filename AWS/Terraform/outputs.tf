output "ec2_public_ip" {
  description = "EC2 Public IP Address"
  value       = module.ec2.public_ip
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = module.ec2.instance_id
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}