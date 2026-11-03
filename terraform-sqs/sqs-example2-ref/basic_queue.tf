resource "aws_sqs_queue" "basic" {
  name = "example-basic-queue-69127"

  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600 # 4 days
  max_message_size           = 262144 # 256 KB
  delay_seconds              = 0
  receive_wait_time_seconds  = 10 # simple long polling

  tags = {
    Environment = "dev"
    Team        = "backend"
  }
}
