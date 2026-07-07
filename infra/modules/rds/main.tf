#DB Subnet Group

resource "aws_db_subnet_group" "main" {
  name       = "assessment-db-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name = "assessment-db-subnet-group"
  }
}

#PostgreSQL Instance

resource "aws_db_instance" "postgres" {
  identifier = "assessment-postgres"

  engine         = "postgres"
  engine_version = "16"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type       = "gp3"

  db_name  = var.db_name
  username = var.username
  password = var.password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]

  publicly_accessible = false
  skip_final_snapshot = true
}