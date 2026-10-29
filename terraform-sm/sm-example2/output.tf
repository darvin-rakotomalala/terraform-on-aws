output "secret_arn" {
  value = aws_secretsmanager_secret.application_secret.arn
}