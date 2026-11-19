#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "artifacts" {
  bucket        = "${data.aws_caller_identity.current.account_id}-${var.name}-artifacts"
  force_destroy = true

  #checkov:skip=CKV_AWS_18: AWS Access logging not enabled on S3 buckets
  #checkov:skip=CKV2_AWS_61: An S3 bucket must have a lifecycle configuration
  #Above rules are for deprecated properties.

  #checkov:skip=CKV_AWS_144: S3 bucket cross-region replication disabled
  #This bucket is used for storing access logs for the load balancer, and does not require another bucket to store this bucket's access logs.

  #checkov:skip=CKV_AWS_21: AWS S3 Object Versioning is disabled
  #The items in this S3 bucket do not require versioning.

  #checkov:skip=CKV2_AWS_62: S3 buckets do not have event notifications enabled
  #The items in this s3 bucket are access logs and do not require any event notifications to be sent anywhere.

  #checkov:skip=CKV_AWS_145: Ensure that S3 buckets are encrypted with KMS by default
  #The only server-side encryption option that's supported is Amazon S3-managed keys (SSE-S3)
  #This bucket is already encrypted below using SSE-S3.
  #resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt_bucket" {}
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "artifacts" {
  bucket                  = aws_s3_bucket.artifacts.id
  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt_bucket" {
  bucket = aws_s3_bucket.artifacts.bucket
  rule {
    apply_server_side_encryption_by_default {
      #The only server-side encryption option that's supported is Amazon S3-managed keys (SSE-S3) 
      #https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html#access-log-create-bucket
      sse_algorithm = "AES256"
    }
  }
}

# Apply Bucket Policy
resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.artifacts.id
  policy = data.aws_iam_policy_document.iam-policy-1.json
}

data "aws_iam_policy_document" "iam-policy-1" {
  statement {
    sid    = "AllowELBRootAccount"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.artifacts.id}",
      "arn:aws:s3:::${aws_s3_bucket.artifacts.id}/*",
    ]
    actions = ["s3:PutObject"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
  depends_on = [aws_s3_bucket_public_access_block.artifacts]
}
