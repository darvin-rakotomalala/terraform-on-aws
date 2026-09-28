#################################################
### Monitoring EventBridge
#################################################
/*
AWS EventBridge publishes key metrics to CloudWatch, enabling you to monitor performance and set up alarms.
The most critical metrics include:
  - Invocations: Number of times a rule is triggered.
  - FailedInvocations: Number of failed rule invocations.
  - ThrottledRules: Number of rules that were throttled due to rate limits.
  - TriggeredRules: Number of rules triggered by events.
  - DeadLetterInvocations: Number of events sent to a Dead Letter Queue (DLQ) due to failure.
*/

/*
### 1. Set a retry policy
resource "aws_cloudwatch_event_target" "target" {
  arn  = aws_sqs_queue.data_queue.arn
  rule = aws_cloudwatch_event_rule.s3_createobject.name
  retry_policy {
    maximum_event_age_in_seconds = 3600 // 3600 seconds = 1 hour
    maximum_retry_attempts       = 20
  }
}

### 2. Send failed events to SQS Dead-letter Queue
resource "aws_cloudwatch_event_target" "target" {
  arn  = aws_sqs_queue.data_queue.arn
  rule = aws_cloudwatch_event_rule.s3_createobject.name

  dead_letter_config {
    arn = aws_sqs_queue.dead_letter_queue.arn
  }
}

### 3. Use EventBridge Archives
resource "aws_cloudwatch_event_archive" "archive" {
  name             = "default"
  event_source_arn = data.aws_cloudwatch_event_bus.default.arn
}

### 4. Add CloudWatch as a target
resource "aws_cloudwatch_event_target" "logs" {
  rule = aws_cloudwatch_event_rule.s3_createobject.name
  arn  = aws_cloudwatch_log_group.eventbridge.tf.arn
}

resource "aws_cloudwatch_log_group" "eventbridge.tf" {
  name              = "/aws/events/eventbridge.tf/logs-69127"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_resource_policy" "logs" {
  policy_document = data.aws_iam_policy_document.eventbridge_log_policy.json
  policy_name     = "eventbridge_log_publishing-policy"
}

data "aws_iam_policy_document" "eventbridge_log_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream"
    ]
    resources = [
      "${aws_cloudwatch_log_group.eventbridge.tf.arn}:*"
    ]
    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com",
        "delivery.logs.amazonaws.com"
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents"
    ]
    resources = [
      "${aws_cloudwatch_log_group.eventbridge.tf.arn}:*:*"
    ]
    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com",
        "delivery.logs.amazonaws.com"
      ]
    }
    condition {
      test     = "ArnEquals"
      values   = [aws_cloudwatch_event_rule.s3_createobject.arn]
      variable = "aws:SourceArn"
    }
  }
}
*/
