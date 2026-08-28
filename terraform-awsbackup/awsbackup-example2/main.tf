data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

#####################################
# # Backup Vault
#####################################
resource "aws_backup_vault" "ec2" {
  name = "ec2-backups-69127"
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

    resources = [aws_backup_vault.ec2.arn]
  }
}

resource "aws_backup_vault_policy" "vault_pol" {
  backup_vault_name = aws_backup_vault.ec2.name
  policy            = data.aws_iam_policy_document.vault_policy.json
}

resource "aws_backup_plan" "ec2" {
  name = "ec2-daily-monthly-69127"

  rule {
    rule_name         = "daily"
    target_vault_name = aws_backup_vault.ec2.name
    schedule          = "cron(0 5 ? * * *)"
    start_window      = 60
    completion_window = 180

    lifecycle {
      delete_after = 35
    }
  }

  rule {
    rule_name         = "monthly"
    target_vault_name = aws_backup_vault.ec2.name
    schedule          = "cron(0 5 1 * ? *)"
    start_window      = 60
    completion_window = 360

    lifecycle {
      cold_storage_after = 30
      delete_after       = 365
    }
  }

  rule {
    rule_name         = "DailyWithCrossRegionCopy_rule"
    target_vault_name = aws_backup_vault.ec2.name
    schedule          = "cron(0 12 * * ? *)"
    start_window      = 60
    completion_window = 180
    lifecycle {
      delete_after = 35
    }
    # Define the copy action
    copy_action {
      destination_vault_arn = aws_backup_vault.destination_vault.arn
      lifecycle {
        delete_after = 90 # Days to keep the copy
      }
    }
  }

}

#####################################
# Cross-Region Backup Copies
#####################################
resource "aws_backup_vault" "destination_vault" {
  provider   = aws.west
  name       = "destination-backup-vault-69127"
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
  name               = "my-backup-role-69127"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Policy Attachment
resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.my_bck_up_role.name
}

#####################################
# Backup Selection
#####################################
resource "aws_backup_selection" "ec2" {
  iam_role_arn = aws_iam_role.my_bck_up_role.arn
  name         = "tagged-ec2-instances-69127"
  plan_id      = aws_backup_plan.ec2.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}
