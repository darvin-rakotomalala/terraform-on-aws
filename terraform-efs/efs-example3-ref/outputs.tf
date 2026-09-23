output "efs_id" {
  value       = aws_efs_file_system.efs.id
  description = "EFS file system ID"
}

output "efs_dns_name" {
  value       = aws_efs_file_system.efs.dns_name
  description = "EFS DNS name for mounting"
}
