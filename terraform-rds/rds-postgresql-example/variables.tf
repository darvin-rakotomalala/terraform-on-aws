variable "db_username" {
  description = "RDS root username"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "RDS root user password"
  default     = "Root2025"
  # sensitive   = true
}
