########################################
## AWS Backup Vault - This is where all your backup data lives.
########################################

# Primary backup vault with KMS encryption
resource "aws_kms_key" "backup_key" {
  description             = "KMS key for backup encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    Purpose = "backup-encryption"
  }
}

resource "aws_backup_vault" "primary" {
  name        = "primary-backup-vault"
  kms_key_arn = aws_kms_key.backup_key.arn

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

# Secondary vault in another region for DR
resource "aws_backup_vault" "dr_vault" {
  provider    = aws.dr_region
  name        = "dr-backup-vault"
  kms_key_arn = aws_kms_key.dr_backup_key.arn

  tags = {
    Environment = "production"
    Purpose     = "disaster-recovery"
  }
}
