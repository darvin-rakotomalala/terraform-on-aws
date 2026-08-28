resource "aws_backup_vault" "backup_vault" {
  name = "backup_vault_69127"
}

resource "local_file" "vault_access_policy" {
  filename        = "vault-access-policy.json"
  file_permission = 0644
  content         = <<EOT
    {
      "Version": "2012-10-17",
      "Statement": [
          {
            "Effect": "Deny",
            "Principal": "*",
            "Action": ["backup:DeleteRecoveryPoint",
                       "backup:DeleteBackupVault",
                       "backup:PutBackupVaultAccessPolicy",
                       "backup:DeleteBackupVaultAccessPolicy"],
            "Resource": "${aws_backup_vault.backup_vault.arn}"
          }
      ]
    }
    EOT
}

resource "null_resource" "put-backup-vault-access-policy" {
  triggers = {
    policy = local_file.vault_access_policy.content
  }

  provisioner "local-exec" {
    command = "aws backup put-backup-vault-access-policy --region ${data.aws_region.current.region} --backup-vault-name ${aws_backup_vault.backup_vault.name} --policy file://vault-access-policy.json"
  }
  depends_on = [aws_backup_vault.backup_vault, local_file.vault_access_policy]
}
