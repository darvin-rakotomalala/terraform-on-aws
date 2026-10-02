# 1. Create a Customer Managed Key (CMK) in KMS
resource "aws_kms_key" "s3_key" {
  description             = "KMS key for S3 bucket encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 7 # Minimum waiting period to prevent accidental data loss

  # Key policy that allows the S3 service principal to use the key
  # The "Condition" block restricts key usage to S3 operations in a specific region
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM policies"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow S3 use of the key"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:ViaService"    = "s3.${data.aws_region.current.region}.amazonaws.com"
            "kms:CallerAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}

# Create an alias for the KMS key
resource "aws_kms_alias" "s3_key_alias" {
  # The alias name must always start with the "alias/" prefix
  name          = "alias/my-s3-key"
  target_key_id = aws_kms_key.s3_key.key_id
}

# 2. Define the S3 bucket
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-kms-encrypted-bucket-69127" # Must be globally unique
}

# 3. Configure the S3 bucket to use the KMS key for default encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_key.arn
    }
    # Optional: Enable S3 Bucket Keys to reduce KMS request costs
    bucket_key_enabled = true
  }
}

# Optional: Enforce encryption in transit (best practice)
resource "aws_s3_bucket_policy" "force_https" {
  bucket = aws_s3_bucket.secure_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "ForceHTTPS"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource  = "${aws_s3_bucket.secure_bucket.arn}/*"
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
