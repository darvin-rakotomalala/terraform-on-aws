# Create cross-region replicas
provider "aws" {
  region = "us-east-2"
  alias  = "replica"
}

resource "aws_db_instance_automated_backups_replication" "default" {
  source_db_instance_arn = aws_db_instance.default.arn
  retention_period       = 14
  
  kms_key_id             = aws_kms_key.my_kms_key_us_east2.arn
  provider               = aws.replica
}

resource "aws_kms_key" "my_kms_key_us_east2" {
  description             = "My KMS Key for RDS Encryption"
  deletion_window_in_days = 30

  tags = {
    Name = "MyKMSKey"
  }

  provider = aws.replica
}
