########################################
## Vault Lock for Immutable Backups - To protect against ransomware and
# accidental deletion, use vault lock to make backups immutable.
########################################

# Vault lock prevents anyone from deleting backups during the retention period
resource "aws_backup_vault_lock_configuration" "primary" {
  backup_vault_name   = aws_backup_vault.primary.name
  min_retention_days  = 7
  max_retention_days  = 365
  changeable_for_days = 3 # Grace period to remove the lock
}
