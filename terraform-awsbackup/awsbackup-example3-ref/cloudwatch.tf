#########################################
# Monitoring Your Backups
#########################################
resource "aws_cloudwatch_metric_alarm" "backup_failures" {
  alarm_name          = "backup-job-failures-69127"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NumberOfBackupJobsFailed"
  namespace           = "AWS/Backup"
  period              = 86400 # 24 hours
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Alert when any backup job fails"
  alarm_actions       = [aws_sns_topic.alerts.arn]
}
