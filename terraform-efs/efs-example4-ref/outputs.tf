# outputs.tf
output "efs_id" {
  description = "EFS File System ID"
  value       = aws_efs_file_system.main.id
}

output "efs_dns_name" {
  description = "EFS DNS name"
  value       = aws_efs_file_system.main.dns_name
}

output "mount_target_ids" {
  description = "Mount target IDs"
  value       = aws_efs_mount_target.main[*].id
}

output "access_point_id" {
  description = "EFS Access Point ID"
  value       = aws_efs_access_point.test.id
}
