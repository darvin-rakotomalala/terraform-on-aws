######################################################
### FIFO Queue Configuration
######################################################
# FIFO Queue
resource "aws_sqs_queue" "fifo" {
  name                        = "${var.project_name}-queue-69127.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600
  max_message_size           = 262144
  delay_seconds              = 0
  receive_wait_time_seconds  = 0

  tags = {
    Environment = var.environment
  }
}

# Dead Letter Queue
resource "aws_sqs_queue" "dlq" {
  name = "${var.project_name}-dlq-69127"

  tags = {
    Environment = var.environment
  }
}

# Main Queue with DLQ
resource "aws_sqs_queue" "with_dlq" {
  name = "${var.project_name}-with-dlq-69127"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })

  tags = {
    Environment = var.environment
  }
}
