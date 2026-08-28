########################################
## Backup Plans - that specify when and how often backups occur.
########################################

# Comprehensive backup plan with multiple schedules
resource "aws_backup_plan" "production" {
  name = "production-backup-plan"

  # Daily backups - keep for 35 days
  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.primary.name
    schedule          = "cron(0 3 * * ? *)" # 3 AM UTC daily
    start_window      = 60                  # minutes
    completion_window = 180                 # minutes

    lifecycle {
      delete_after = 35
    }

    # Copy to DR region
    copy_action {
      destination_vault_arn = aws_backup_vault.dr_vault.arn
      lifecycle {
        delete_after = 35
      }
    }
  }

  # Weekly backups - keep for 90 days
  rule {
    rule_name         = "weekly-backup"
    target_vault_name = aws_backup_vault.primary.name
    schedule          = "cron(0 4 ? * SUN *)" # Sunday 4 AM UTC
    start_window      = 60
    completion_window = 360

    lifecycle {
      delete_after = 90
    }

    copy_action {
      destination_vault_arn = aws_backup_vault.dr_vault.arn
      lifecycle {
        delete_after = 90
      }
    }
  }

  # Monthly backups - keep for 365 days
  rule {
    rule_name         = "monthly-backup"
    target_vault_name = aws_backup_vault.primary.name
    schedule          = "cron(0 5 1 * ? *)" # 1st of month, 5 AM UTC
    start_window      = 60
    completion_window = 720

    lifecycle {
      cold_storage_after = 30
      delete_after       = 365
    }

    copy_action {
      destination_vault_arn = aws_backup_vault.dr_vault.arn
      lifecycle {
        cold_storage_after = 30
        delete_after       = 365
      }
    }
  }

  tags = {
    Environment = "production"
  }
}
