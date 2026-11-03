######################################################
### Message Processing Pipeline
######################################################
/*
resource "aws_sqs_queue" "processing" {
  name = "${var.project_name}-processing-69127"

  visibility_timeout_seconds = 60
  receive_wait_time_seconds  = 20 # Enable long polling

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_lambda_event_source_mapping" "processing" {
  event_source_arn = aws_sqs_queue.processing.arn
  function_name    = var.lambda_function_arn
  batch_size       = 10
}
*/

######################################################
### Fan-Out Pattern
######################################################
/*
resource "aws_sns_topic" "main" {
  name = "${var.project_name}-topic-69127"
}

resource "aws_sqs_queue" "subscribers" {
  count = length(var.subscriber_names)
  name  = "${var.project_name}-${var.subscriber_names[count.index]}"
}

resource "aws_sns_topic_subscription" "subscribers" {
  count     = length(aws_sqs_queue.subscribers)
  topic_arn = aws_sns_topic.main.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.subscribers[count.index].arn
}
*/