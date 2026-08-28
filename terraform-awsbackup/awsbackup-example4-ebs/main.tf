# fetch all volumes
data "aws_ebs_volumes" "volumes" {
  filter {
    name   = "tag:Name"
    values = ["*"]
  }
}

data "aws_ebs_volume" "data" {
  for_each = toset(data.aws_ebs_volumes.volumes.ids)
  filter {
    name   = "volume-id"
    values = [each.value]
  }
}

resource "aws_iam_role" "ebs_aws_backup_role" {
  name = "${local.prefix}-role-69127"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AssumeServiceRole"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "ebs_aws_backup_service_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.ebs_aws_backup_role.name
}

resource "aws_backup_vault" "ebs_backup_vault" {
  name = "${local.prefix}-vault-69127"
  tags = local.tags
}

resource "aws_backup_plan" "ebs_backup_plan" {
  name = "${local.prefix}-plan-69127"

  rule {
    rule_name         = "${local.prefix}-rule-${local.backups.retention}-day"
    target_vault_name = aws_backup_vault.ebs_backup_vault.name
    schedule          = local.backups.schedule
    start_window      = 60
    completion_window = 300

    lifecycle {
      cold_storage_after = local.backups.cold_storage_after
      delete_after       = local.backups.retention
    }
  }

  tags = local.tags
}

resource "aws_backup_selection" "ebs_backup_selection" {
  iam_role_arn = aws_iam_role.ebs_aws_backup_role.arn
  name         = "${local.prefix}-selection"
  plan_id      = aws_backup_plan.ebs_backup_plan.id

  resources = [for v in data.aws_ebs_volume.data : v.arn]
}
