resource "aws_db_parameter_group" "db_param_group" {
  name   = "postgres-test"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

# create a RDS Database Instance
resource "aws_db_instance" "db_test" {
  allocated_storage      = 20
  identifier             = "postgres-test"
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"
  username               = "postgres"
  password               = "postgres"
  vpc_security_group_ids = [aws_security_group.allow_postgres_traffic.id]
  parameter_group_name   = aws_db_parameter_group.db_param_group.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
