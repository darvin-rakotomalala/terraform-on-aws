#########################################################
### Basic KMS Configuration
#########################################################
# KMS Key
resource "aws_kms_key" "main" {
  description             = "KMS key for ${var.project_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })

  tags = {
    Environment = var.environment
  }
}

# KMS Alias
resource "aws_kms_alias" "main" {
  name          = "alias/${var.project_name}"
  target_key_id = aws_kms_key.main.key_id
}

# Data source for current account
data "aws_caller_identity" "current" {}

#########################################################
### Multi-Region Key Configuration
#########################################################
# Primary Region Key
resource "aws_kms_key" "primary" {
  description             = "Multi-region primary key for ${var.project_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  multi_region            = true

  tags = {
    Environment = var.environment
  }
}

# Secondary Region Key
resource "aws_kms_replica_key" "secondary" {
  provider = aws.secondary

  description             = "Multi-region replica key for ${var.project_name}"
  deletion_window_in_days = 7
  primary_key_arn         = aws_kms_key.primary.arn

  tags = {
    Environment = var.environment
  }
}

#########################################################
### Key Policy Configuration
#########################################################
# Key with detailed policy
resource "aws_kms_key" "restricted" {
  description             = "Restricted KMS key for ${var.project_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow Service Access"
        Effect = "Allow"
        Principal = {
          Service = [
            "s3.amazonaws.com",
            "rds.amazonaws.com"
          ]
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      },
      {
        Sid    = "Allow Specific IAM Roles"
        Effect = "Allow"
        Principal = {
          # AWS = var.allowed_role_arns
          AWS = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/darvin-admin"]
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Environment = var.environment
  }
}

/*
#########################################################
### Cross-Account Access
#########################################################
# Key Policy for Cross-Account Access
resource "aws_kms_key" "cross_account" {
  description             = "Cross-account KMS key for ${var.project_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable Cross Account Access"
        Effect = "Allow"
        Principal = {
          # AWS = var.trusted_account_arns
          AWS = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/darvin-admin"]
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })
}
*/

/*
#########################################################
### Grant Configuration
#########################################################
# Key Grant
resource "aws_kms_grant" "example" {
  name              = "${var.project_name}-grant"
  key_id            = aws_kms_key.main.id
  grantee_principal = aws_iam_role.example.arn
  operations = [
    "Encrypt",
    "Decrypt",
    "GenerateDataKey"
  ]

  constraints {
    encryption_context_equals = {
      Environment = var.environment
    }
  }
}
*/

#########################################################
### Monitoring Configuration
#########################################################
# CloudWatch Alarm for Key Usage
resource "aws_cloudwatch_metric_alarm" "key_usage" {
  alarm_name          = "${var.project_name}-key-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "NumberOfOperations"
  namespace           = "AWS/KMS"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1000"
  alarm_description   = "This metric monitors KMS key usage"
  # alarm_actions      = [var.sns_topic_arn]

  dimensions = {
    KeyId = aws_kms_key.main.id
  }
}

