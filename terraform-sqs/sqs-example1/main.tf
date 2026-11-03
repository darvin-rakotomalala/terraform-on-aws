resource "aws_sqs_queue" "tf_queue" {
  name                       = "sqs-example-queue-69127"
  delay_seconds              = 10
  visibility_timeout_seconds = 30
  max_message_size           = 262144
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 2
  sqs_managed_sse_enabled    = true
}

data "aws_iam_policy_document" "tf_sqs_policy" {
  statement {
    sid    = "tfsqsstatement"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.tf_queue.arn
    ]
  }
}

resource "aws_sqs_queue_policy" "sh_sqs_policy" {
  queue_url = aws_sqs_queue.tf_queue.id
  policy    = data.aws_iam_policy_document.tf_sqs_policy.json
}
