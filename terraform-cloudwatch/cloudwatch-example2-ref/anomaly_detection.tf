###########################################################
# Anomaly Detection Alarm
###########################################################
resource "aws_cloudwatch_metric_alarm" "anomaly" {
  alarm_name          = "${var.project_name}-anomaly"
  comparison_operator = "GreaterThanUpperThreshold"
  evaluation_periods  = "2"
  threshold_metric_id = "e1"
  alarm_description   = "This metric monitors for anomalous behavior"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  metric_query {
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1)"
    label       = "CPUUtilization (Expected)"
    return_data = true
  }

  metric_query {
    id = "m1"
    metric {
      metric_name = "CPUUtilization"
      namespace   = "AWS/EC2"
      period      = "300"
      stat        = "Average"
      dimensions = {
        InstanceId = aws_instance.web.id
      }
    }
    return_data = true # The final output for the alarm
  }
}
