# -----------------------------------------------------------
# set up logging bucket keys
# -----------------------------------------------------------

resource "aws_kms_key" "log_key" {
  deletion_window_in_days = 7
  description             = "Log Bucket Encryption Key"
  enable_key_rotation     = true
  tags = {
    Name        = "Log Bucket Key"
    Environment = "DEV"
  }
}

resource "aws_kms_alias" "log_key" {
  name          = "alias/log_key"
  target_key_id = aws_kms_key.log_key.id
}

resource "aws_kms_key" "cloudtrail_key" {
  deletion_window_in_days = 7
  description             = "CloudTrail Log Encryption Key"
  enable_key_rotation     = true
  tags = {
    Name        = "CloudTrail Key"
    Environment = "DEV"
  }
  policy = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "Enable IAM User Permissions",
          "Effect": "Allow",
          "Principal": {
            "AWS": [
              "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            ]
          },
          "Action": "kms:*",
          "Resource": "*"
        },
        {
          "Sid": "Allow CloudTrail to encrypt logs",
          "Effect": "Allow",
          "Principal": {
            "Service": "cloudtrail.amazonaws.com"
          },
          "Action": "kms:GenerateDataKey*",
          "Resource": "*",
          "Condition": {
            "StringLike": {
              "kms:EncryptionContext:aws:cloudtrail:arn": [
                "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
              ]
            }
          }
        },
        {
          "Sid": "Enable log decrypt permissions",
          "Effect": "Allow",
          "Principal": {
            "AWS": [
              "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            ]
          },
          "Action": ["kms:Decrypt"],
          "Resource": "*",
          "Condition": {
            "StringEquals": {
              "kms:CallerAccount" : "${data.aws_caller_identity.current.account_id}",
              "kms:ViaService": "s3.${data.aws_region.current.region}.amazonaws.com",
              "kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:trail/${var.trail_name}"
            },
            "StringLike" : {
              "kms:EncryptionContext:aws:s3:arn":"${aws_s3_bucket.log_bucket.arn}/${var.trail_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/CloudTrail/${data.aws_region.current.region}/*"
            }
          }
        },
        {
          "Sid": "Allow CloudWatch Access",
          "Effect": "Allow",
          "Principal": {
            "Service": "logs.${data.aws_region.current.region}.amazonaws.com"
          },
          "Action": [
            "kms:Encrypt*",
            "kms:Decrypt*",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:Describe*"
          ],
          "Resource": "*"
        },
        {
          "Sid": "Allow Describe Key access",
          "Effect": "Allow",
          "Principal": {
            "Service": ["cloudtrail.amazonaws.com", "lambda.amazonaws.com"]
          },
          "Action": "kms:DescribeKey",
          "Resource": "*"
        }
      ]
    }
POLICY
}

resource "aws_kms_alias" "cloudtrail_key" {
  name          = "alias/cloudtrail_key"
  target_key_id = aws_kms_key.cloudtrail_key.id
}
