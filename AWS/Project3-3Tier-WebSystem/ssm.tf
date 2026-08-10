resource "aws_ssm_parameter" "environment" {
  name  = "/${var.project_name}/environment"
  type  = "String"
  value = "development"

  tags = {
    Name = "${var.project_name}-environment"
  }
}

resource "aws_ssm_parameter" "rds_endpoint" {
  name  = "/${var.project_name}/database/endpoint"
  type  = "String"
  value = aws_db_instance.main.address

  tags = {
    Name = "${var.project_name}-rds-endpoint"
  }
}