# -----------------------------------------------------------
# set up logging bucket
# -----------------------------------------------------------

resource "aws_s3_bucket" "log_bucket" {
  bucket_prefix = var.bucket_prefix
  region        = data.aws_region.current.region
  force_destroy = true # Add or update this line
  tags = {
    Name        = "Log Bucket"
    Environment = "DEV"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.log_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example_encryption" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.log_key.arn
    }
    # Optional: Enable S3 Bucket Keys to potentially reduce KMS request costs
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_policy" "log_bucket_policy" {
  bucket = aws_s3_bucket.log_bucket.id

  policy = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "Allow bucket ACL check",
          "Effect": "Allow",
          "Principal": {
            "Service": [
              "cloudtrail.amazonaws.com",
              "logs.${data.aws_region.current.region}.amazonaws.com",
              "lambda.amazonaws.com"
              ]
            },
          "Action": "s3:GetBucketAcl",
          "Resource": "${aws_s3_bucket.log_bucket.arn}"
        },
        {
          "Sid": "Allow bucket write",
          "Effect": "Allow",
          "Principal": {
            "Service": [
              "cloudtrail.amazonaws.com",
              "logs.${data.aws_region.current.region}.amazonaws.com"
            ]
          },
          "Action": "s3:PutObject",
          "Resource": "${aws_s3_bucket.log_bucket.arn}/*",
          "Condition": {"StringEquals": {"s3:x-amz-acl": "bucket-owner-full-control"}}
        },
        {
          "Sid": "Allow bucket write for lambda",
          "Effect": "Allow",
          "Principal": {
            "Service": [
              "lambda.amazonaws.com"
            ]
          },
          "Action": "s3:PutObject",
          "Resource": "${aws_s3_bucket.log_bucket.arn}/*"
        }
      ]
    }
POLICY
}
