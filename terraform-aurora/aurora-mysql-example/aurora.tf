# Aurora DB Cluster
resource "aws_rds_cluster" "aurora_mysql_cluster" {
  cluster_identifier = "my-aurora-mysql-cluster"
  engine             = "aurora-mysql"
  # engine_version         = "8.0.mysql_aurora.3.02.0" # Specify your desired version
  engine_version         = "5.7.mysql_aurora.2.12.0"
  database_name          = "my_aurora_db"
  master_username        = "root"
  master_password        = "root2025" # Use a secure method for managing secrets
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]
  skip_final_snapshot    = true # Set to false for production
  apply_immediately      = true
  storage_encrypted      = false # Set to true if needed

  tags = {
    Name = "Aurora MySQL Cluster"
  }
}

# Aurora DB Instances
resource "aws_rds_cluster_instance" "aurora_instance_1" {
  cluster_identifier  = aws_rds_cluster.aurora_mysql_cluster.id
  instance_class      = "db.t3.small" # Choose appropriate instance class
  engine              = aws_rds_cluster.aurora_mysql_cluster.engine
  engine_version      = aws_rds_cluster.aurora_mysql_cluster.engine_version
  publicly_accessible = false # Set to true if needed, but generally not recommended for production
  tags = {
    Name = "Aurora MySQL Instance 1"
  }
}

resource "aws_rds_cluster_instance" "aurora_instance_2" {
  cluster_identifier  = aws_rds_cluster.aurora_mysql_cluster.id
  instance_class      = "db.t3.small"
  engine              = aws_rds_cluster.aurora_mysql_cluster.engine
  engine_version      = aws_rds_cluster.aurora_mysql_cluster.engine_version
  publicly_accessible = false
  tags = {
    Name = "Aurora MySQL Instance 2"
  }
}
