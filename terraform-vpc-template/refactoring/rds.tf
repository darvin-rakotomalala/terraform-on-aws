resource "aws_db_instance" "project" {
  allocated_storage      = 8
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  db_name                = var.rds_name
  db_subnet_group_name   = aws_db_subnet_group.project.name
  username               = var.rds_username
  password               = var.rds_password
  parameter_group_name   = var.rds_parameter_group_name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.private_database_sg.id]
}

resource "aws_db_subnet_group" "project" {
  name       = "mydb_rds"
  subnet_ids = aws_subnet.private_project_subnet[*].id

  tags = {
    Name = "My DB subnet group"
  }
}
