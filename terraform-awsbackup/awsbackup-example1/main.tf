data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

##########################################
# Backup Vault Resource
##########################################
resource "aws_backup_vault" "my_vault" {
  name = "my-backup-vault"
}

# Backup Vault Policy
data "aws_iam_policy_document" "vault_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"] # Use the source account's root ARN
    }

    actions = [
      "backup:DescribeBackupVault",
      "backup:DeleteBackupVault",
      "backup:CopyIntoBackupVault",
      "backup:PutBackupVaultAccessPolicy",
      "backup:DeleteBackupVaultAccessPolicy",
      "backup:GetBackupVaultAccessPolicy",
      "backup:StartBackupJob",
      "backup:GetBackupVaultNotifications",
      "backup:PutBackupVaultNotifications",
    ]

    resources = [aws_backup_vault.my_vault.arn]
  }
}

resource "aws_backup_vault_policy" "vault_pol" {
  backup_vault_name = aws_backup_vault.my_vault.name
  policy            = data.aws_iam_policy_document.vault_policy.json
}

##########################################
# Backup Plan Resource
##########################################
resource "aws_backup_plan" "my_back_plan" {
  name = "my-backup-plan"
  rule {
    rule_name         = "my-backup-rule"
    target_vault_name = aws_backup_vault.my_vault.name
    schedule          = "cron(0 11 * * ? *)" # backups will be triggered daily at 11:00 AM UTC.
    start_window      = 60
    completion_window = 180

    lifecycle {
      delete_after = 14 # deleted after 14 days
    }
  }
}

##########################################
# # Selecting Backup by resource
##########################################
resource "aws_backup_selection" "my_selection" {
  iam_role_arn = aws_iam_role.my_bck_up_role.arn
  name         = "test_selection"
  plan_id      = aws_backup_plan.my_back_plan.id

  resources = [
    "arn:aws:ec2:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:instance/i-0b0fae6836c00e863"
  ]
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# IAM Role
resource "aws_iam_role" "my_bck_up_role" {
  name               = "my-backup-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Policy Attachment
resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.my_bck_up_role.name
}
