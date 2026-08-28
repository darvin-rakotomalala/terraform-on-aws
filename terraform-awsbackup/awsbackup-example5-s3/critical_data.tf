module "aws_backup_critical" {
  source     = "lgallard/backup/aws"
  vault_name = "${local.service_name}-s3-backup-critical-data"
  plan_name  = "${local.service_name}-s3-backup-critical-data-plan"
  notifications = {
    sns_topic_arn       = data.aws_sns_topic.failed_backups.arn
    backup_vault_events = ["BACKUP_JOB_FAILED"]
  }

  rules = [
    {
      name     = "${local.service_name}-s3-backup-critical-data-rule"
      schedule = "cron(5 2 * * ? *)"
      copy_actions = [
        {
          lifecycle = {
            cold_storage_after = 90
            delete_after       = 1825
          },
          destination_vault_arn = var.central_s3_vault_arn
        },
      ]
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
      name      = "${local.service_name}-s3-critical-data-selection"
      resources = ["arn:aws:s3:::prefix-dummy-${local.environment}-database-critical-data-bucket", "arn:aws:s3:::dummy-${local.environment}-critical-data-logs"]
    }
  ]
}
