# Create S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "tf-test-s3-2025"
  tags = {
    Name       = "tf-s3"
    Enviroment = "demo"
  }
}

# Upload Files to S3 Bucket Using aws_s3_bucket_object
resource "aws_s3_object" "object1" {
  bucket   = aws_s3_bucket.my_bucket.bucket
  for_each = fileset("uploads/", "*")
  key      = each.value
  source   = "uploads/${each.value}"
}

# Manage ACL (Access Control List) Using aws_s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "app" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Create an S3 bucket policy that allows read-only access to a specific IAM user or role
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = data.aws_iam_policy_document.allow_read_only_access.json
}

### My Account_ID ###
data "aws_caller_identity" "darvin_account" {}

data "aws_iam_policy_document" "allow_read_only_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["${data.aws_caller_identity.darvin_account.account_id}"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.my_bucket.arn,
      "${aws_s3_bucket.my_bucket.arn}/*",
    ]
  }
}
