#########################################
# Cross-Region Backup Copies
#########################################
# Vault in the DR region
resource "aws_backup_vault" "dr" {
  provider    = aws.dr_region
  name        = "dr-backup-vault-69127"
  kms_key_arn = aws_kms_key.backup_dr.arn
}

# Add copy action to your backup plan rule
resource "aws_backup_plan" "with_cross_region" {
  name = "cross-region-backup-plan-69127"

  rule {
    rule_name         = "daily-with-copy"
    target_vault_name = aws_backup_vault.main.name
    schedule          = "cron(0 3 * * ? *)"

    lifecycle {
      delete_after = 90
    }

    copy_action {
      destination_vault_arn = aws_backup_vault.dr.arn

      lifecycle {
        delete_after = 90
      }
    }
  }
}
