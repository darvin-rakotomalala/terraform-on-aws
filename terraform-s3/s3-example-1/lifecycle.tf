# Configuring Lifecycle Rules for S3 Buckets
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    id     = "Example-lifecycle-rule"
    status = "Enabled"

    filter {}

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 365
    }
  }

  rule {
    id     = "Allow small object transitions"
    status = "Enabled"

    filter {
      object_size_greater_than = 1
    }

    transition {
      days          = 365
      storage_class = "GLACIER_IR"
    }
  }
}
