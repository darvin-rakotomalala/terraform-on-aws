output "flow_log_id" {
  description = "The ID of the created VPC Flow Log"
  value       = aws_flow_log.main.id
}

output "flow_log_arn" {
  description = "The ARN of the created VPC Flow Log"
  value       = aws_flow_log.main.arn
}
