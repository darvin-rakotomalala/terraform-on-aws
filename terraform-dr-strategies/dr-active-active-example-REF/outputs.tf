# =============================================================================
# Outputs
# =============================================================================

output "website_url" {
  description = "Main website URL (failover enabled)"
  value       = "https://${var.domain_name}"
}

# VPC Outputs
output "primary_vpc_id" {
  description = "Primary VPC ID"
  value       = aws_vpc.primary.id
}

output "secondary_vpc_id" {
  description = "Secondary VPC ID"
  value       = aws_vpc.secondary.id
}

# ALB Outputs
output "primary_alb_dns" {
  description = "Primary ALB DNS name"
  value       = aws_lb.primary.dns_name
}

output "secondary_alb_dns" {
  description = "Secondary ALB DNS name"
  value       = aws_lb.secondary.dns_name
}

# EC2 Outputs
output "primary_ec2_id" {
  description = "Primary EC2 instance ID (stop this to test failover)"
  value       = aws_instance.primary.id
}

output "secondary_ec2_id" {
  description = "Secondary EC2 instance ID"
  value       = aws_instance.secondary.id
}

# Route 53 Outputs
output "health_check_id" {
  description = "Route 53 health check ID"
  value       = aws_route53_health_check.primary.id
}

# Helper Commands
output "test_failover_command" {
  description = "Command to test failover"
  value       = "aws ec2 stop-instances --instance-ids ${aws_instance.primary.id} --region us-east-1"
}

output "recover_primary_command" {
  description = "Command to recover primary"
  value       = "aws ec2 start-instances --instance-ids ${aws_instance.primary.id} --region us-east-1"
}
