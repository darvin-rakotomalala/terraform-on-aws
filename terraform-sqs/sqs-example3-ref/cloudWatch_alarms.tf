######################################################
### Monitoring Configuration
######################################################
# CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "queue_depth" {
  alarm_name          = "${var.project_name}-queue-depth-69127"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = "300"
  statistic           = "Average"
  threshold           = "1000"
  alarm_description   = "This metric monitors queue depth"
  # alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    QueueName = aws_sqs_queue.standard.name
  }
}

resource "aws_cloudwatch_metric_alarm" "dlq_messages" {
  alarm_name          = "${var.project_name}-dlq-messages"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors DLQ messages"
  # alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    QueueName = aws_sqs_queue.dlq.name
  }
}
