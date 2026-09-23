########################################
### Basic EFS File System
########################################
resource "aws_efs_file_system" "main" {
  creation_token = "prod-shared-storage"
  encrypted      = true

  performance_mode = "generalPurpose" # or "maxIO" for highly parallel workloads
  throughput_mode  = "bursting"       # or "elastic" for unpredictable workloads

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS" # Move files to Infrequent Access after 30 days
  }

  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS" # Move back on first access
  }

  tags = {
    Name        = "prod-shared-storage"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

########################################
### Mount Targets
########################################
### This creates a mount target in each private subnet
variable "private_subnet_ids" {
  type        = map(string)
  description = "Map of AZ to private subnet ID"
  default = {
    "us-east-1a" = "subnet-abc123"
    "us-east-1b" = "subnet-def456"
    "us-east-1c" = "subnet-ghi789"
  }
}

resource "aws_efs_mount_target" "main" {
  for_each = var.private_subnet_ids

  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs.id]
}

########################################
### Access Points
########################################
resource "aws_efs_access_point" "api" {
  file_system_id = aws_efs_file_system.main.id

  # Force all operations to use this POSIX identity
  posix_user {
    gid = 1000
    uid = 1000
  }

  # Create and use this directory as the root
  root_directory {
    path = "/api-data"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "755"
    }
  }

  tags = {
    Name    = "api-access-point"
    Service = "api"
  }
}

resource "aws_efs_access_point" "worker" {
  file_system_id = aws_efs_file_system.main.id

  posix_user {
    gid = 1001
    uid = 1001
  }

  root_directory {
    path = "/worker-data"
    creation_info {
      owner_gid   = 1001
      owner_uid   = 1001
      permissions = "755"
    }
  }

  tags = {
    Name    = "worker-access-point"
    Service = "worker"
  }
}

########################################
### EFS File System Policy
########################################
resource "aws_efs_file_system_policy" "main" {
  file_system_id = aws_efs_file_system.main.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnforceEncryptionInTransit"
        Effect = "Deny"
        Principal = {
          AWS = "*"
        }
        Action   = "*"
        Resource = aws_efs_file_system.main.arn
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        Sid    = "AllowSpecificRole"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.ecs_task.arn
        }
        Action = [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite"
        ]
        Resource = aws_efs_file_system.main.arn
      }
    ]
  })
}

########################################
# Backup Configuration : EFS integrates with AWS Backup. While EFS has its own automatic backups,
# using AWS Backup gives you more control over retention and cross-region copying.
########################################

resource "aws_backup_vault" "efs" {
  name = "efs-backup-vault"
}

resource "aws_backup_plan" "efs" {
  name = "efs-daily-backup"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.efs.name
    schedule          = "cron(0 3 * * ? *)" # 3 AM UTC daily

    lifecycle {
      delete_after = 35 # Keep backups for 35 days
    }
  }
}

resource "aws_backup_selection" "efs" {
  name         = "efs-selection"
  plan_id      = aws_backup_plan.efs.id
  iam_role_arn = aws_iam_role.backup.arn

  resources = [
    aws_efs_file_system.main.arn
  ]
}

########################################
# CloudWatch Monitoring : EFS publishes metrics that you should be watching.
# The most important ones are BurstCreditBalance (for bursting throughput mode)
# and PercentIOLimit (for general-purpose mode).
########################################
resource "aws_cloudwatch_metric_alarm" "burst_credits" {
  alarm_name          = "efs-low-burst-credits"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "BurstCreditBalance"
  namespace           = "AWS/EFS"
  period              = 300
  statistic           = "Average"
  threshold           = 1000000000000 # 1 TB in bytes
  alarm_description   = "EFS burst credits running low"

  dimensions = {
    FileSystemId = aws_efs_file_system.main.id
  }

  alarm_actions = [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "io_limit" {
  alarm_name          = "efs-high-io-percentage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "PercentIOLimit"
  namespace           = "AWS/EFS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "EFS approaching IO limit"

  dimensions = {
    FileSystemId = aws_efs_file_system.main.id
  }

  alarm_actions = [var.sns_topic_arn]
}
