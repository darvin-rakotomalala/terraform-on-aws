###########################################################
# Primary Alarm
###########################################################
resource "aws_cloudwatch_metric_alarm" "primary" {
  alarm_name          = "${var.project_name}-primary"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
}

###########################################################
# Secondary Alarm
###########################################################
resource "aws_cloudwatch_metric_alarm" "secondary" {
  alarm_name          = "${var.project_name}-secondary"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
}

###########################################################
# Composite Alarm
###########################################################
resource "aws_cloudwatch_composite_alarm" "composite" {
  alarm_name = "${var.project_name}-composite"
  alarm_rule = "ALARM(${aws_cloudwatch_metric_alarm.primary.alarm_name}) AND ALARM(${aws_cloudwatch_metric_alarm.secondary.alarm_name})"

  alarm_actions = [aws_sns_topic.alerts.arn]
}
