/*
resource "aws_sqs_queue" "data_queue" {
  name = "data-queue-69127"
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = aws_sqs_queue.data_queue.url
  policy    = data.aws_iam_policy_document.sqs-queue-policy.json
}

data "aws_iam_policy_document" "sqs-queue-policy" {
  policy_id = "arn:aws:sqs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:data-queue-69127/SQSDefaultPolicy"

  statement {
    sid    = "data-sns-topic"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    actions = [
      "SQS:SendMessage",
    ]
    resources = [
      "arn:aws:sqs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:data-queue-69127",
    ]
    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values = [
        aws_cloudwatch_event_rule.s3_createobject.arn,
      ]
    }
  }
}
*/
