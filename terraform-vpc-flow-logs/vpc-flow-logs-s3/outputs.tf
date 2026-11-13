output "flow_log_id" {
  description = "ID of the VPC flow log"
  value       = aws_flow_log.vpc_to_s3.id
}

output "s3_bucket_name" {
  description = "S3 bucket for flow logs"
  value       = aws_s3_bucket.flow_logs.bucket
}

output "athena_database" {
  description = "Athena database name"
  value       = aws_athena_database.flow_logs.name
}
