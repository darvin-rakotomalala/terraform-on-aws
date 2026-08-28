resource "aws_kms_key" "vault_kms" {
  description = "Vault kms key for encryption"
  policy      = <<POLICY
      {
          "Id": "vault-kms-policy",
          "Version": "2012-10-17",
          "Statement": [
              {
                  "Sid": "Enable IAM User Permissions",
                  "Effect": "Allow access to view and describe key",
                  "Principal": {
                      "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
                  },
                  "Action": [
                      "kms:ListResourceTags",
                      "kms:GetKeyPolicy",
                      "kms:Describe*"
                  ],
                  "Resource": "*"
              },
              {
                  "Sid": "Allow access for Key Administrators",
                  "Effect": "Allow",
                  "Principal": {
                      "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/github_ci"
                  },
                  "Action": [
                      "kms:Create*",
                      "kms:Describe*",
                      "kms:Enable*",
                      "kms:List*",
                      "kms:Put*",
                      "kms:Update*",
                      "kms:Revoke*",
                      "kms:Disable*",
                      "kms:Get*",
                      "kms:Delete*",
                      "kms:TagResource",
                      "kms:UntagResource",
                      "kms:ScheduleKeyDeletion",
                      "kms:CancelKeyDeletion"
                  ],
                  "Resource": "*"
              },
              {
                  "Sid": "Allow use of the key",
                  "Effect": "Allow",
                  "Principal": {
                      "AWS": [
                          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/kms_usage",
                          "arn:aws:iam::${var.workload_account_id}:root"
                      ]
                  },
                  "Action": [
                      "kms:Encrypt",
                      "kms:Decrypt",
                      "kms:ReEncrypt*",
                      "kms:GenerateDataKey*",
                      "kms:DescribeKey"
                  ],
                  "Resource": "*"
              },
              {
                  "Sid": "Allow attachment of persistent resources",
                  "Effect": "Allow",
                  "Principal": {
                      "AWS": [
                          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/vault_role",
                          "arn:aws:iam::${var.workload_account_id}:root"
                      ]
                  },
                  "Action": [
                      "kms:CreateGrant",
                      "kms:ListGrants",
                      "kms:RevokeGrant"
                  ],
                  "Resource": "*",
                  "Condition": {
                      "Bool": {
                          "kms:GrantIsForAWSResource": "true"
                      }
                  }
              }
          ]
      }
  POLICY
}

resource "aws_kms_alias" "aws_kms_alias" {
  name          = "alias/aws-backup-kms-69127"
  target_key_id = aws_kms_key.vault_kms.key_id
}
