data "aws_secretsmanager_secret" "dbcreds" {
  name = "dbcreds"
}

data "aws_secretsmanager_secret_version" "secret_credentials" {
  secret_id = data.aws_secretsmanager_secret.dbcreds.id
}

# Create an AWS DB instance resource that requires secrets
resource "aws_db_instance" "mydb_mysql" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.4"
  instance_class       = "db.t3.micro"
  username             = jsondecode(data.aws_secretsmanager_secret_version.secret_credentials.secret_string)["db_username"]
  password             = jsondecode(data.aws_secretsmanager_secret_version.secret_credentials.secret_string)["db_password"]
  parameter_group_name = "default.mysql8.4"

  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.project.name
  vpc_security_group_ids = [aws_security_group.private_database_sg.id]
}
