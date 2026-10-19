resource "aws_db_instance" "db_test" {
  allocated_storage      = 20
  engine                 = "mysql" # Or your desired engine (e.g., postgres, aurora)
  engine_version         = "5.7"
  storage_type           = "gp2"
  instance_class         = "db.t3.micro"
  identifier             = "my-rds-instance"
  username               = "root"
  password               = "root2025" # Use a secure method for credentials
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true # Set to false for production environments
  tags = {
    Name = "My RDS Instance"
  }
}
