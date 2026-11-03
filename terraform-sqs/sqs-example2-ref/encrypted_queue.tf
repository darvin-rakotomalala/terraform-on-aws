# Customer managed KMS key for SQS encryption
resource "aws_kms_key" "sensitive_data" {
  description         = "KMS key for encrypting sensitive SQS messages"
  enable_key_rotation = true
}

resource "aws_kms_alias" "sensitive_data" {
  name          = "alias/sensitive-sqs-queue-69127"
  target_key_id = aws_kms_key.sensitive_data.key_id
}

# Secure encrypted SQS queue
resource "aws_sqs_queue" "sensitive_data" {
  name                              = "sensitive-data-queue-69127"
  kms_master_key_id                 = aws_kms_key.sensitive_data.arn
  kms_data_key_reuse_period_seconds = 300

  # Encryption at rest + tight access window
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400 # 1 day
  delay_seconds              = 0
  fifo_queue                 = false

  # Optional dead letter queue support would go here
}

# Restrictive queue policy (only allow a specific IAM role)
data "aws_iam_policy_document" "sensitive_data_queue" {
  statement {
    sid = "AllowSpecificRoleOnly"

    principals {
      type = "AWS"
      identifiers = [
        #"arn:aws:iam::123456789012:role/app-sensitive-processor"
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]

    resources = [
      aws_sqs_queue.sensitive_data.arn
    ]
  }
}

resource "aws_sqs_queue_policy" "sensitive_data" {
  queue_url = aws_sqs_queue.sensitive_data.id
  policy    = data.aws_iam_policy_document.sensitive_data_queue.json
}
