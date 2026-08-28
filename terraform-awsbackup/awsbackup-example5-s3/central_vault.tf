# Used to aggregate snapshots from workload account
resource "aws_backup_vault" "central_vault" {
  name        = "central-aws-vault-S3-69127"
  kms_key_arn = aws_kms_key.vault_kms.arn
}

resource "aws_backup_vault_lock_configuration" "locker" {
  backup_vault_name   = aws_backup_vault.central_vault.name
  changeable_for_days = 3
  max_retention_days  = 35
  min_retention_days  = 15
}

resource "aws_backup_vault_policy" "central_vault_allowance" {
  backup_vault_name = aws_backup_vault.central_vault.name
  policy            = <<POLICY
      {
        "Version": "2012-10-17",
        "Id": "default",
        "Statement": [
          {
            "Sid": "Allow Tool Prod Account to copy into iemtrialcluster_backup_vault",
            "Effect": "Allow",
            "Action": "backup:CopyIntoBackupVault",
            "Resource": "*",
            "Principal": {
              "AWS": "arn:aws:iam::${var.workload_account_id}:root"
            }
          }
        ]
      }
  POLICY
}
