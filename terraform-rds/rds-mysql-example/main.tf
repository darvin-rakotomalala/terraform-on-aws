# main.tf
# create a RDS Database Instance
resource "aws_db_instance" "myinstance" {
  engine                 = "mysql"
  db_name                = "myrdsinstance"
  identifier             = "myrdsinstance"
  allocated_storage      = 20
  engine_version         = "5.7"
  storage_type           = "gp2"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.default.id
  vpc_security_group_ids = [aws_security_group.allow_mysql_traffic.id]
  skip_final_snapshot    = true // required to destroy
  publicly_accessible    = true
  tags = {
    Name = "myrdsinstance-db"
  }
}
