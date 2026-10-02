data "aws_caller_identity" "current" {}

resource "aws_kms_key" "primary" {
  description         = "CMK for AWS CB Blog"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.kms.json
  multi_region        = true
}

resource "aws_kms_alias" "alias" {
  target_key_id = aws_kms_key.primary.id
  name          = format("alias/%s", lower("MY_DEMO_CMK"))
}

resource "aws_kms_replica_key" "secondary" {
  provider = aws.secondary

  description             = "Multi-Region replica key"
  deletion_window_in_days = 7
  primary_key_arn         = aws_kms_key.primary.arn
}

resource "aws_kms_replica_key" "tertiary" {
  provider = aws.tertiary

  description             = "Multi-Region replica key"
  deletion_window_in_days = 7
  primary_key_arn         = aws_kms_key.primary.arn
}

data "aws_iam_policy_document" "kms" {
  # Allow root users full management access to key
  statement {
    effect = "Allow"
    actions = [
      "kms:*"
    ]

    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  # Allow other accounts limited access to key
  statement {
    effect = "Allow"
    actions = [
      "kms:CreateGrant",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    resources = ["*"]

    # AWS account IDs that need access to this key
    principals {
      type = "AWS"
      # identifiers = var.account_ids
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.username}"]
    }
  }
}
