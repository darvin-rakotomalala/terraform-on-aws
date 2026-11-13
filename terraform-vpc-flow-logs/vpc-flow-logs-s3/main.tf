########################################
## Basic S3 Flow Logs Setup - flow logs that deliver to an S3 bucket
########################################

# Reference the VPC
data "aws_vpc" "main" {
  tags = { Name = "main-vpc" }
}

# S3 bucket for flow logs
resource "aws_s3_bucket" "flow_logs" {
  bucket = "my-vpc-flow-logs-bucket"

  tags = { Name = "vpc-flow-logs" }
}

# Enable versioning for compliance
resource "aws_s3_bucket_versioning" "flow_logs" {
  bucket = aws_s3_bucket.flow_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "flow_logs" {
  bucket = aws_s3_bucket.flow_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "flow_logs" {
  bucket = aws_s3_bucket.flow_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# VPC Flow Log to S3
resource "aws_flow_log" "vpc_to_s3" {
  vpc_id               = data.aws_vpc.main.id
  traffic_type         = "ALL"
  log_destination      = aws_s3_bucket.flow_logs.arn
  log_destination_type = "s3"

  # Deliver logs in Parquet format for better query performance
  destination_options {
    # Use Parquet format for better compression and query performance.
    # Enable Hive-compatible partitions for efficient Athena queries.
    file_format                = "parquet"
    hive_compatible_partitions = true
    per_hour_partition         = true
  }

  max_aggregation_interval = 60

  tags = { Name = "vpc-flow-log-s3" }
}

########################################
## S3 Lifecycle Policies - rules to manage storage costs
########################################

# Lifecycle policy for cost optimization
resource "aws_s3_bucket_lifecycle_configuration" "flow_logs" {
  bucket = aws_s3_bucket.flow_logs.id

  # Move to Infrequent Access after 30 days
  rule {
    id     = "transition-to-ia"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    # Move to Glacier after 90 days
    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    # Move to Glacier Deep Archive after 365 days
    transition {
      days          = 365
      storage_class = "DEEP_ARCHIVE"
    }

    # Delete after 7 years (compliance requirement)
    expiration {
      days = 2555
    }
  }

  # Clean up incomplete multipart uploads
  rule {
    id     = "cleanup-multipart"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

########################################
## Custom Log Format for S3 - Define a custom log format with additional fields
########################################

# Flow log with custom format
resource "aws_flow_log" "vpc_custom_s3" {
  vpc_id               = data.aws_vpc.main.id
  traffic_type         = "ALL"
  log_destination      = aws_s3_bucket.flow_logs.arn
  log_destination_type = "s3"

  # Custom log format with extensive fields
  log_format = join(" ", [
    "$${version}",
    "$${account-id}",
    "$${interface-id}",
    "$${srcaddr}",
    "$${dstaddr}",
    "$${srcport}",
    "$${dstport}",
    "$${protocol}",
    "$${packets}",
    "$${bytes}",
    "$${start}",
    "$${end}",
    "$${action}",
    "$${log-status}",
    "$${vpc-id}",
    "$${subnet-id}",
    "$${az-id}",
    "$${pkt-srcaddr}",
    "$${pkt-dstaddr}",
    "$${region}",
    "$${pkt-src-aws-service}",
    "$${pkt-dst-aws-service}",
    "$${flow-direction}",
    "$${traffic-path}",
  ])

  destination_options {
    file_format                = "parquet"
    hive_compatible_partitions = true
    per_hour_partition         = true
  }

  max_aggregation_interval = 60

  tags = { Name = "vpc-flow-log-custom-s3" }
}

########################################
## Setting Up Athena for Querying
########################################



########################################
## Cross-Account Flow Logs - Send flow logs from multiple accounts to a central S3 bucket
########################################

# S3 bucket policy allowing cross-account flow log delivery
resource "aws_s3_bucket_policy" "flow_logs" {
  bucket = aws_s3_bucket.flow_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSLogDeliveryWrite"
        Effect = "Allow"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.flow_logs.arn}/AWSLogs/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl"      = "bucket-owner-full-control"
            "aws:SourceAccount" = ["111111111111", "222222222222", "333333333333"]
          }
        }
      },
      {
        Sid    = "AWSLogDeliveryCheck"
        Effect = "Allow"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.flow_logs.arn
      }
    ]
  })
}
