resource "aws_sqs_queue" "orders_fifo" {
  name = "orders-events-69127.fifo"

  fifo_queue                  = true
  content_based_deduplication = true

  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600 # 4 days
  delay_seconds              = 0
  max_message_size           = 262144

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.orders_dlq_fifo.arn
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue" "orders_dlq_fifo" {
  name                        = "orders-events-dlq-69127.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}
