# Create the Aurora PostgreSQL cluster
resource "aws_rds_cluster" "aurora_postgres" {
  cluster_identifier     = "my-aurora-postgres-cluster"
  engine                 = "aurora-postgresql"
  engine_version         = "17.5" # Specify your desired PostgreSQL version
  database_name          = "my_aurora_db"
  master_username        = "postgres"
  master_password        = "root2025" # Use AWS Secrets Manager in production
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]
  skip_final_snapshot    = true # Set to false in production for backups
  apply_immediately      = true
  tags = {
    Name = "MyAuroraPostgresCluster"
  }
}

# Create an Aurora PostgreSQL instance within the cluster
resource "aws_rds_cluster_instance" "aurora_postgres_instance" {
  count               = 1 # Number of instances (writer + readers)
  cluster_identifier  = aws_rds_cluster.aurora_postgres.id
  instance_class      = "db.r6g.large" # Choose appropriate instance class
  engine              = aws_rds_cluster.aurora_postgres.engine
  engine_version      = aws_rds_cluster.aurora_postgres.engine_version
  publicly_accessible = false # Set to true if needed, but not recommended for production
  tags = {
    Name = "MyAuroraPostgresInstance-${count.index}"
  }
}
