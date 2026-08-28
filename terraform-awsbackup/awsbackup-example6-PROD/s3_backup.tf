########################################
## S3 Backup with Versioning and Replication - For S3 buckets, you need versioning and
# cross-region replication rather than traditional backups.
########################################

# Source bucket with versioning
resource "aws_s3_bucket" "data" {
  bucket = "myapp-production-data"

  tags = {
    Backup = "true"
  }
}

resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Lifecycle rules to manage old versions
resource "aws_s3_bucket_lifecycle_configuration" "data" {
  bucket = aws_s3_bucket.data.id

  rule {
    id     = "move-old-versions"
    status = "Enabled"

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class   = "GLACIER"
    }

    noncurrent_version_expiration {
      noncurrent_days = 365
    }
  }
}

# DR bucket in another region
resource "aws_s3_bucket" "data_replica" {
  provider = aws.dr_region
  bucket   = "myapp-production-data-replica"
}

resource "aws_s3_bucket_versioning" "data_replica" {
  provider = aws.dr_region
  bucket   = aws_s3_bucket.data_replica.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Cross-region replication
resource "aws_s3_bucket_replication_configuration" "data" {
  depends_on = [aws_s3_bucket_versioning.data]
  role       = aws_iam_role.replication_role.arn
  bucket     = aws_s3_bucket.data.id

  rule {
    id     = "replicate-all"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.data_replica.arn
      storage_class = "STANDARD_IA"
    }
  }
}
