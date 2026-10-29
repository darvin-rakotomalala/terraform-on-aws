resource "aws_db_subnet_group" "project" {
  name       = "mydb_rds"
  subnet_ids = aws_subnet.private_project_subnet[*].id

  tags = {
    Name = "My DB subnet group"
  }
}