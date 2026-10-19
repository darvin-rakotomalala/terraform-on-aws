# Configure a basic RDS instance
resource "aws_db_instance" "default" {
  allocated_storage = 20
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.4"
  instance_class    = "db.t3.medium"
  identifier        = "mydb"
  username          = "root"
  password          = "Root2025"

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name

  backup_retention_period = 7                     # Number of days to retain automated backups
  backup_window           = "23:30-00:00"         # Preferred UTC backup window (hh24:mi-hh24:mi format)
  maintenance_window      = "mon:04:00-mon:04:30" # Preferred UTC maintenance window

  # Enable automated backups
  skip_final_snapshot = true // required to destroy
  # skip_final_snapshot       = false
  # final_snapshot_identifier = "my-db-snap"

  # Enable enhanced monitoring
  monitoring_interval = 60 # Interval in seconds (minimum 60 seconds)
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn

  # Enable performance insights
  performance_insights_enabled = true

  # Associate with parameter group
  parameter_group_name = aws_db_parameter_group.my_db_pmg.name

  # Specify the KMS key ID for encryption (replace with your own KMS key ARN)
  storage_encrypted = true
  kms_key_id        = aws_kms_key.my_kms_key.arn

  # Enable Multi-AZ deployment for high availability
  multi_az = true

  tags = {
    Name = "My RDS Instance"
  }
}

# Provision an RDS instance in a VPC network
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "rds_monitoring_attachment" {
  name       = "rds-monitoring-attachment"
  roles      = [aws_iam_role.rds_monitoring_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_parameter_group" "my_db_pmg" {
  name   = "my-db-pg"
  family = "mysql8.4"

  parameter {
    name  = "connect_timeout"
    value = "15"
  }

  # more parameters...
  # parameter {
  # name = "<parameter name>"
  # value = "<valid value>"
  # }
}

# Encryption
resource "aws_kms_key" "my_kms_key" {
  description             = "My KMS Key for RDS Encryption"
  deletion_window_in_days = 30

  tags = {
    Name = "MyKMSKey"
  }
}

# Replica
resource "aws_db_instance" "replica" {
  replicate_source_db          = aws_db_instance.default.identifier
  instance_class               = "db.t3.medium"
  vpc_security_group_ids       = [aws_security_group.rds_sg.id]
  backup_retention_period      = 7                     # Number of days to retain automated backups
  backup_window                = "23:30-00:00"         # Preferred UTC backup window (hh24:mi-hh24:mi format)
  maintenance_window           = "mon:04:00-mon:04:30" # Preferred UTC maintenance window
  skip_final_snapshot          = true // required to destroy
  final_snapshot_identifier    = "my-db-snap"
  monitoring_interval          = 60
  monitoring_role_arn          = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled = true
  storage_encrypted            = true
  kms_key_id                   = aws_kms_key.my_kms_key.arn
  parameter_group_name         = aws_db_parameter_group.my_db_pmg.name
  # Enable Multi-AZ deployment for high availability
  multi_az = true
  tags = {
    Name = "My RDS Replica"
  }
}
