output "efs_id" {
  value       = aws_efs_file_system.main.id
  description = "EFS file system ID"
}

output "efs_dns_name" {
  value       = aws_efs_file_system.main.dns_name
  description = "EFS DNS name for mounting"
}

output "access_point_ids" {
  value = {
    api    = aws_efs_access_point.api.id
    worker = aws_efs_access_point.worker.id
  }
  description = "Access point IDs by service"
}
