output "security_group_id" {
  description = "Web Security Group ID"
  value       = aws_security_group.web_sg.id
}