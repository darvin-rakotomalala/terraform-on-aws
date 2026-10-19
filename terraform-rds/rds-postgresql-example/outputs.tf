output "db_instance_endpoint" {
  value = aws_db_instance.db_test.endpoint
}

output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.db_test.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.db_test.port
  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.db_test.username
  sensitive   = true
}

output "security_group_id" {
  value = aws_security_group.allow_postgres_traffic.id
}
