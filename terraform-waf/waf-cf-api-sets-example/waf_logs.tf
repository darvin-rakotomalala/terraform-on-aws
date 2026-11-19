resource "aws_cloudwatch_log_group" "example_waf_logs" {
  name = "aws-waf-logs-example" # Note the prefix
}

resource "aws_wafv2_web_acl_logging_configuration" "example_waf_logging_configuration" {
  log_destination_configs = [aws_cloudwatch_log_group.example_waf_logs.arn]
  resource_arn            = aws_wafv2_web_acl.example_acl.arn
}

resource "aws_cloudwatch_log_resource_policy" "example_waf_logs_policypolicy" {
  policy_document = data.aws_iam_policy_document.example_waf_iam_policy.json
  policy_name     = "webacl-policy-example"
}

data "aws_region" "current" {}

data "aws_iam_policy_document" "example_waf_iam_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.example_waf_logs.arn}:*"]
    condition {
      test     = "ArnLike"
      values   = ["arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:*"]
      variable = "aws:SourceArn"
    }
    condition {
      test     = "StringEquals"
      values   = [tostring(data.aws_caller_identity.current.account_id)]
      variable = "aws:SourceAccount"
    }
  }
}
