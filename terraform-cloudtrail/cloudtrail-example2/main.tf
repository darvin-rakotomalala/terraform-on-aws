data "aws_caller_identity" "current" {}

resource "aws_iam_role" "cloudtrail_role" {
  name = "CloudTrail_CloudWatchLogs_Role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudtrail.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

data "aws_iam_policy_document" "cloudtrail_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["${aws_cloudwatch_log_group.cloudtrail_log_group.arn}:*"]
  }
}

resource "aws_iam_role_policy" "cloudtrail_policy_attachment" {
  name   = "CloudTrail_CloudWatchLogs_Policy"
  role   = aws_iam_role.cloudtrail_role.id
  policy = data.aws_iam_policy_document.cloudtrail_policy.json
}

resource "aws_cloudtrail" "my_trail" {
  name                          = "my_trail_69127"
  s3_bucket_name                = aws_s3_bucket.trail.id
  s3_key_prefix                 = "cloudtrailkey"
  include_global_service_events = true

  # Link to CloudWatch Logs
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail_log_group.arn}:*" # Append :* here
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_role.arn
  depends_on                 = [aws_s3_bucket_policy.CloudtrailS3, aws_s3_bucket.trail]
}

resource "aws_s3_bucket" "trail" {
  bucket        = "internal-test-task-trail-69127"
  force_destroy = true
}

resource "aws_cloudwatch_log_group" "cloudtrail_log_group" {
  name              = "/aws/cloudtrail/my-trail-logs-69127"
  retention_in_days = 7
}

resource "aws_s3_bucket_policy" "CloudtrailS3" {
  bucket     = aws_s3_bucket.trail.id
  depends_on = [aws_s3_bucket.trail]

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AWSCloudTrailAclCheck",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudtrail.amazonaws.com"
        },
        "Action" : "s3:GetBucketAcl",
        "Resource" : "${aws_s3_bucket.trail.arn}"
      },
      {
        "Sid" : "AWSCloudTrailWrite",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudtrail.amazonaws.com"
        },
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.trail.arn}/cloudtrailkey/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        "Condition" : {
          "StringEquals" : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
