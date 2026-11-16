#---------RDS-----------
# This is going to be our RDS Mysql database, it will be on a t2.micro
# Attached is the database SG
# along with the subnet group that the RDS will deploy into. 
# the subnet group has both our private Subnets to deploy into. 
resource "aws_db_instance" "project" {
  allocated_storage      = 8
  engine                 = "mysql"
  engine_version         = "8.4"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  db_subnet_group_name   = aws_db_subnet_group.project.name #must be specified or it will be created in Defualt VPC
  username               = "root"
  password               = "root69127"
  parameter_group_name   = "default.mysql8.4"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.private_database_sg.id]
}

resource "aws_db_subnet_group" "project" {
  name       = "mydb_rds"
  subnet_ids = [aws_subnet.private_project_subnet_1a.id, aws_subnet.private_project_subnet_1b.id]

  tags = {
    Name = "My DB subnet group"
  }
}
