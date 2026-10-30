################################################
### Basic SNS Configuration
################################################

data "aws_caller_identity" "current" {}

# SNS Topic
resource "aws_sns_topic" "main" {
  name = "${var.project_name}-topic"

  tags = {
    Environment = var.environment
  }
}

# Topic Policy
resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.main.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Default SNS Policy"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "SNS:GetTopicAttributes",
          "SNS:SetTopicAttributes",
          "SNS:AddPermission",
          "SNS:RemovePermission",
          "SNS:DeleteTopic",
          "SNS:Subscribe",
          "SNS:ListSubscriptionsByTopic",
          "SNS:Publish"
        ]
        Resource = aws_sns_topic.main.arn
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" : data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}

################################################
### Subscription Configuration
################################################

# Email Subscription
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "email"
  endpoint  = var.email_endpoint
}

/*
# Lambda Subscription
resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "lambda"
  endpoint  = var.lambda_function_arn
}

# SQS Subscription
resource "aws_sns_topic_subscription" "sqs" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "sqs"
  endpoint  = var.sqs_queue_arn
}

# HTTP/HTTPS Endpoint
resource "aws_sns_topic_subscription" "https" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "https"
  endpoint  = var.https_endpoint
}
*/

################################################
### FIFO Topic Configuration
################################################
# FIFO Topic
resource "aws_sns_topic" "fifo" {
  name                        = "${var.project_name}.fifo"
  fifo_topic                  = true
  content_based_deduplication = true

  tags = {
    Environment = var.environment
  }
}

/*
# FIFO Topic Subscription (SQS FIFO Queue)
resource "aws_sns_topic_subscription" "fifo_sqs" {
  topic_arn = aws_sns_topic.fifo.arn
  protocol  = "sqs"
  endpoint  = var.fifo_queue_arn
}
*/

################################################
### Cross-Account Access
################################################
# Topic Policy for Cross-Account Access
/*
resource "aws_sns_topic_policy" "cross_account" {
  arn = aws_sns_topic.main.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CrossAccountPublish"
        Effect = "Allow"
        Principal = {
          AWS = var.allowed_aws_account_ids
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.main.arn
      }
    ]
  })
}
*/

################################################
### Message Filtering
################################################
/*
# Subscription with Filter Policy
resource "aws_sns_topic_subscription" "filtered" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "sqs"
  endpoint  = var.sqs_queue_arn

  filter_policy = jsonencode({
    environment = ["production"]
    severity    = ["high", "critical"]
  })
}
*/

################################################
### Dead Letter Queue Configuration
################################################
/*
# DLQ for Failed Message Delivery
resource "aws_sqs_queue" "dlq" {
  name = "${var.project_name}-dlq"
}

resource "aws_sns_topic_subscription" "with_dlq" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "lambda"
  endpoint  = var.lambda_function_arn

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
  })
}
*/

################################################
### Monitoring Configuration
################################################

# CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "failed_deliveries" {
  alarm_name          = "${var.project_name}-failed-deliveries"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "NumberOfNotificationsFailed"
  namespace           = "AWS/SNS"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric monitors failed SNS deliveries"
  alarm_actions       = [aws_sns_topic.main.arn]

  dimensions = {
    TopicName = aws_sns_topic.main.name
  }
}
