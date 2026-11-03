######################################################
### Basic SQS Configuration
######################################################
# Standard Queue
resource "aws_sqs_queue" "standard" {
  name = "${var.project_name}-queue-69127"

  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600 # 4 days
  max_message_size           = 262144 # 256 KB
  delay_seconds              = 0
  receive_wait_time_seconds  = 0

  tags = {
    Environment = var.environment
  }
}

# Queue Policy
resource "aws_sqs_queue_policy" "standard" {
  queue_url = aws_sqs_queue.standard.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action   = "SQS:*"
        Resource = aws_sqs_queue.standard.arn
        /*Condition = {
          ArnEquals = {
            "aws:SourceArn" : var.source_arn
          }
        }*/
      }
    ]
  })
}

######################################################
### Cross-Account Access
######################################################
# Queue Policy for Cross-Account Access
/*
resource "aws_sqs_queue_policy" "cross_account" {
  queue_url = aws_sqs_queue.standard.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.allowed_account_arns
        }
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage"
        ]
        Resource = aws_sqs_queue.standard.arn
      }
    ]
  })
}
*/
