#########################################
# Backup Plan
#########################################
resource "aws_backup_plan" "main" {
  name = "main-backup-plan-69127"

  # Daily backup rule - runs every day at 3 AM UTC
  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.main.name
    schedule          = "cron(0 3 * * ? *)"
    start_window      = 60  # minutes to start the backup
    completion_window = 180 # minutes to complete the backup

    lifecycle {
      cold_storage_after = 30  # move to cold storage after 30 days
      delete_after       = 120 # delete after 120 days
    }

    recovery_point_tags = {
      BackupType = "daily"
      ManagedBy  = "terraform"
    }
  }

  # Monthly backup rule - runs on the 1st of every month
  rule {
    rule_name         = "monthly-backup"
    target_vault_name = aws_backup_vault.main.name
    schedule          = "cron(0 3 1 * ? *)"
    start_window      = 60
    completion_window = 360

    lifecycle {
      cold_storage_after = 90
      delete_after       = 365 # keep monthly backups for a year
    }

    recovery_point_tags = {
      BackupType = "monthly"
      ManagedBy  = "terraform"
    }
  }

  tags = {
    Environment = var.environment
  }
}
