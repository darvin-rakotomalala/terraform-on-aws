output "flow_log_id" {
  description = "ID of the VPC flow log"
  value       = aws_flow_log.vpc.id
}

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.flow_logs.name
}

# Output useful CloudWatch Insights queries as reference
output "insights_queries" {
  description = "Useful CloudWatch Insights queries for flow log analysis"
  value = {
    top_talkers        = "stats sum(bytes) as totalBytes by srcAddr | sort totalBytes desc | limit 10"
    rejected_by_source = "filter action = 'REJECT' | stats count(*) as rejectCount by srcAddr | sort rejectCount desc | limit 20"
    traffic_by_port    = "stats count(*) as flowCount, sum(bytes) as totalBytes by dstPort | sort totalBytes desc | limit 20"
  }
}
