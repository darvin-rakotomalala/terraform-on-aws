output "kms_key_id" {
  value = aws_kms_key.clustername[*].arn
}

output "kms_alias_arn" {
  value = aws_kms_alias.clustername-alias[*].arn
}

output "aws_secretsmanager_secret" {
  value = aws_secretsmanager_secret.app-keystore[*].arn
}
