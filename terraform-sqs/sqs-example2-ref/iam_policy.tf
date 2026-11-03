data "aws_iam_policy_document" "orders_consumer" {
  statement {
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:ChangeMessageVisibility",
      "sqs:GetQueueAttributes"
    ]

    resources = [
      aws_sqs_queue.orders_queue.arn
    ]
  }
}
