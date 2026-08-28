#########################################
# Backup Vault
#########################################

# Create a KMS key for encrypting backups
resource "aws_kms_key" "backup" {
  description             = "KMS key for AWS Backup vault encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "backup" {
  name          = "alias/backup-vault-key"
  target_key_id = aws_kms_key.backup.key_id
}

# Create the backup vault
resource "aws_backup_vault" "main" {
  name        = "main-backup-vault-69127"
  kms_key_arn = aws_kms_key.backup.arn

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

#########################################
# Vault Access Policies
#########################################
resource "aws_backup_vault_policy" "main" {
  backup_vault_name = aws_backup_vault.main.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "PreventDeletion"
        Effect = "Deny"
        Principal = {
          AWS = "*"
        }
        Action = [
          "backup:DeleteRecoveryPoint",
          "backup:UpdateRecoveryPointLifecycle"
        ]
        Resource = "*"
      }
    ]
  })
}
