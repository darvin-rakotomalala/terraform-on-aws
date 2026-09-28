#####################################
## Monitoring and Alerts
#####################################

## CloudWatch Metrics
resource "aws_cloudwatch_metric_alarm" "failed_invocations" {
  alarm_name          = "${var.project_name}-failed-invocations"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FailedInvocations"
  namespace           = "AWS/Events"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "EventBridge rule invocation failed"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    RuleName = aws_cloudwatch_event_rule.pattern.name
  }
}

## Dead Letter Queue
resource "aws_sqs_queue" "dlq" {
  name = "${var.project_name}-dlq"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-dlq"
    }
  )
}

resource "aws_cloudwatch_event_target" "with_dlq" {
  rule           = aws_cloudwatch_event_rule.pattern.name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  target_id      = "WithDLQ"
  arn            = aws_lambda_function.handler.arn

  dead_letter_config {
    arn = aws_sqs_queue.dlq.arn
  }
}
