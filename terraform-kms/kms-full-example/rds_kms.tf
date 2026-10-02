#########################################################
### RDS Database Encryption
#########################################################
resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_db_instance" "encrypted" {
  identifier        = "${var.db_name}db"
  db_name           = "${var.db_name}db"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = "root"
  password          = "root69127"

  kms_key_id        = aws_kms_key.rds.arn
  storage_encrypted = true

  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.project.name
  vpc_security_group_ids = [aws_security_group.private_database_sg.id]
}
