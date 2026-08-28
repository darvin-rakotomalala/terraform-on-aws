#########################################
# Vault Lock for Compliance
#########################################
resource "aws_backup_vault_lock_configuration" "main" {
  backup_vault_name   = aws_backup_vault.main.name
  changeable_for_days = 3 # grace period before lock becomes immutable
  max_retention_days  = 365
  min_retention_days  = 7
}
