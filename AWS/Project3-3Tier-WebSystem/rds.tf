resource "aws_db_subnet_group" "main" {
  name = "${var.project_name}-db-subnet-group"

  subnet_ids = aws_subnet.db[*].id

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier = "${var.project_name}-rds"

  engine = "postgres"

  instance_class = var.db_instance_class

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = "cloudlab"
  username = var.db_username

  manage_master_user_password = true

  multi_az = true

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.db.id
  ]

  publicly_accessible = false

  backup_retention_period = 1

  deletion_protection = false

  skip_final_snapshot = true

  apply_immediately = true

  tags = {
    Name = "${var.project_name}-rds"
  }
}