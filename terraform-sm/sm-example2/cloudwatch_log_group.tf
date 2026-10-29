###########################################################
# 6 — Monitoring and Logging
###########################################################
# CloudWatch Log Group for Secrets Manager
resource "aws_cloudwatch_log_group" "secrets_logs" {
  name              = "/aws/secretsmanager/awsmorocco"
  retention_in_days = 14
}

# CloudWatch Metric Alarm for failed secret rotations
resource "aws_cloudwatch_metric_alarm" "rotation_failures" {
  alarm_name          = "awsmorocco-secret-rotation-failures"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "RotationFailed"
  namespace           = "AWS/SecretsManager"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors failed secret rotations"

  dimensions = {
    SecretId = aws_secretsmanager_secret.application_secret.id
  }
}
