module "aws_backup_s3_curated_data" {
  source     = "lgallard/backup/aws"
  vault_name = "${local.service_name}-s3-curated-data-backup"
  plan_name  = "${local.service_name}-s3-backup-curated-data-plan"
  notifications = {
    sns_topic_arn       = data.aws_sns_topic.failed_backups.arn
    backup_vault_events = ["BACKUP_JOB_FAILED"]
  }

  rules = [
    {
      name                     = "${local.service_name}-s3-backup-curated-data-rule"
      schedule                 = "cron(5 2 * * ? *)"
      start_window             = 60
      completion_window        = 180
      enable_continuous_backup = true
      lifecycle = {
        cold_storage_after = null
        delete_after       = 35
      }
    }
  ]
  selections = [
    {
      name      = "${local.service_name}-s3-selection"
      resources = ["arn:aws:s3:::prefix-dummy-${local.environment}-database-curated-data-bucket", "arn:aws:s3:::dummy-${local.environment}-curated-data-logs"]
    }
  ]
}
