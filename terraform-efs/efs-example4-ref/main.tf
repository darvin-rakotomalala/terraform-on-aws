############################################
### EFS Configuration
############################################
# EFS File System
resource "aws_efs_file_system" "main" {
  creation_token = "${var.project_name}-efs"
  encrypted      = true

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  # Lifecycle Management
  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  tags = {
    Name = "${var.project_name}-efs"
  }
}

# Mount Targets
resource "aws_efs_mount_target" "main" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = [aws_security_group.efs.id]
}

# Security Group
resource "aws_security_group" "efs" {
  name        = "${var.project_name}-efs-sg"
  description = "Allow EFS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description     = "NFS from VPC"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = var.allowed_security_group_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-efs-sg"
  }
}

# Backup Policy (Optional)
resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.main.id

  backup_policy {
    status = "ENABLED"
  }
}

# Access Point (Optional)
resource "aws_efs_access_point" "test" {
  file_system_id = aws_efs_file_system.main.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/my-data"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "755"
    }
  }

  tags = {
    Name = "${var.project_name}-access-point"
  }
}

############################################
### Mounting EFS on EC2 Instances
############################################
resource "aws_instance" "example" {
  # ... other configuration ...

  user_data = <<-EOF
              #!/bin/bash
              yum install -y amazon-efs-utils
              mkdir -p /mnt/efs
              mount -t efs ${aws_efs_file_system.main.id}:/ /mnt/efs
              echo "${aws_efs_file_system.main.id}:/ /mnt/efs efs defaults,_netdev 0 0" >> /etc/fstab
        EOF
}

############################################
### Monitoring Configuration
############################################
resource "aws_cloudwatch_metric_alarm" "efs_burst_credit_balance" {
  alarm_name          = "${var.project_name}-efs-burst-credits"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "BurstCreditBalance"
  namespace           = "AWS/EFS"
  period              = "300"
  statistic           = "Average"
  threshold           = "1000000000000"
  alarm_description   = "EFS Burst Credit Balance is too low"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    FileSystemId = aws_efs_file_system.main.id
  }
}
