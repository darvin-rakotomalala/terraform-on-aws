########################################
## RDS Backup Configuration - For databases, you want both automated
# snapshots and manual snapshot copies to another region.
########################################

# RDS instance with backup configuration
resource "aws_db_instance" "production" {
  identifier     = "production-db"
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = "db.r6g.xlarge"

  # Backup configuration
  backup_retention_period  = 35
  backup_window            = "03:00-04:00"
  maintenance_window       = "Mon:04:00-Mon:05:00"
  copy_tags_to_snapshot    = true
  delete_automated_backups = false
  deletion_protection      = true

  # Storage encryption
  storage_encrypted = true
  kms_key_id        = aws_kms_key.backup_key.arn

  tags = {
    Backup      = "true"
    Environment = "production"
  }
}

# Lambda function to copy snapshots cross-region (triggered by EventBridge)
resource "aws_lambda_function" "snapshot_copier" {
  filename      = "snapshot_copier.zip"
  function_name = "rds-snapshot-copier"
  role          = aws_iam_role.snapshot_copier_role.arn
  handler       = "index.handler"
  runtime       = "python3.11"
  timeout       = 300

  environment {
    variables = {
      DR_REGION      = "us-west-2"
      KMS_KEY_ID     = aws_kms_key.dr_backup_key.arn
      RETENTION_DAYS = "35"
    }
  }
}

# EventBridge rule to trigger on RDS snapshot completion
resource "aws_cloudwatch_event_rule" "snapshot_created" {
  name = "rds-snapshot-created"

  event_pattern = jsonencode({
    source      = ["aws.rds"]
    detail-type = ["RDS DB Snapshot Event"]
    detail = {
      EventID = ["RDS-EVENT-0091"]
    }
  })
}
