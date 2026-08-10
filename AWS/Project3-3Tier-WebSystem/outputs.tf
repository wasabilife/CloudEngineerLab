output "vpc_id" {
  value = aws_vpc.main.id
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "asg_name" {
  value = aws_autoscaling_group.app.name
}

output "rds_endpoint" {
  value = aws_db_instance.main.address
}

output "rds_port" {
  value = aws_db_instance.main.port
}

output "ssm_parameter_environment" {
  value = aws_ssm_parameter.environment.name
}

output "ssm_parameter_rds_endpoint" {
  value = aws_ssm_parameter.rds_endpoint.name
}