######################################################
# KMS Key for Queue Encryption
######################################################
resource "aws_kms_key" "queue_encryption" {
  description = "KMS key for SQS queue encryption"

  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Environment = var.environment
  }
}

# Encrypted Queue
resource "aws_sqs_queue" "encrypted" {
  name = "${var.project_name}-encrypted-69127"

  kms_master_key_id                 = aws_kms_key.queue_encryption.key_id
  kms_data_key_reuse_period_seconds = 300

  tags = {
    Environment = var.environment
  }
}
