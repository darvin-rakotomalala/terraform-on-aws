########################################
## Monitoring Backup Health - Backups that you never verify are not really backups.
# Set up monitoring to catch failures early.
########################################

# SNS topic for backup alerts
resource "aws_sns_topic" "backup_alerts" {
  name = "backup-failure-alerts"
}

resource "aws_sns_topic_subscription" "ops_team" {
  topic_arn = aws_sns_topic.backup_alerts.arn
  protocol  = "email"
  endpoint  = "ops-team@company.com"
}

# CloudWatch alarm for backup job failures
resource "aws_cloudwatch_metric_alarm" "backup_failures" {
  alarm_name          = "backup-job-failures"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NumberOfBackupJobsFailed"
  namespace           = "AWS/Backup"
  period              = 86400 # 24 hours
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Alert when any backup job fails"
  alarm_actions       = [aws_sns_topic.backup_alerts.arn]

  dimensions = {
    BackupVaultName = aws_backup_vault.primary.name
  }
}

# EventBridge rule for backup job state changes
resource "aws_cloudwatch_event_rule" "backup_state_change" {
  name = "backup-job-state-change"

  event_pattern = jsonencode({
    source      = ["aws.backup"]
    detail-type = ["Backup Job State Change"]
    detail = {
      state = ["FAILED", "EXPIRED"]
    }
  })
}

resource "aws_cloudwatch_event_target" "backup_alert" {
  rule      = aws_cloudwatch_event_rule.backup_state_change.name
  target_id = "send-to-sns"
  arn       = aws_sns_topic.backup_alerts.arn
}
