# Dead letter queue
resource "aws_sqs_queue" "orders_dlq" {
  name                      = "orders-dlq-69127"
  message_retention_seconds = 1209600 # 14 days

  tags = {
    Environment = "production"
    Service     = "orders"
  }
}

# Main production queue
resource "aws_sqs_queue" "orders_queue" {
  name = "orders-queue-69127"

  # How long a worker has to process a message
  visibility_timeout_seconds = 60

  # Keep messages for 4 days
  message_retention_seconds = 345600

  # Optional delivery delay for new messages
  delay_seconds = 0

  # Long polling to reduce empty receives
  receive_wait_time_seconds = 20

  # Move failing messages to the DLQ after 5 failed receives
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.orders_dlq.arn
    maxReceiveCount     = 5
  })

  tags = {
    Environment = "production"
    Service     = "orders"
  }
}
