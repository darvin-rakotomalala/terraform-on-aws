###########################################################
## Basic CloudWatch Configuration
###########################################################
# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/${var.project_name}"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}

# CloudWatch Metric Alarm
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors EC2 CPU utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = aws_instance.web.id
  }

  tags = {
    Environment = var.environment
  }
}

# SNS Topic for Alerts
resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

###########################################################
## Dashboard Configuration
###########################################################
# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.web.id]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "EC2 CPU Utilization"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "NetworkIn", "InstanceId", aws_instance.web.id],
            ["AWS/EC2", "NetworkOut", "InstanceId", aws_instance.web.id]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "EC2 Network Traffic"
        }
      }
    ]
  })
}

###########################################################
## Log Metrics Configuration
###########################################################
# Log Metric Filter
resource "aws_cloudwatch_log_metric_filter" "error_count" {
  name           = "${var.project_name}-error-count"
  pattern        = "ERROR"
  log_group_name = aws_cloudwatch_log_group.main.name

  metric_transformation {
    name      = "ErrorCount"
    namespace = "${var.project_name}/Errors"
    value     = "1"
  }
}

# Metric Alarm for Log Errors
resource "aws_cloudwatch_metric_alarm" "error_count" {
  alarm_name          = "${var.project_name}-error-count"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ErrorCount"
  namespace           = "${var.project_name}/Errors"
  period              = "300"
  statistic           = "Sum"
  threshold           = "10"
  alarm_description   = "This metric monitors error count in logs"
  alarm_actions       = [aws_sns_topic.alerts.arn]
}
