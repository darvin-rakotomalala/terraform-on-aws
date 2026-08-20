output "rds_vpc_endpoint_dns" {
  description = "DNS names for the RDS VPC endpoint"
  value       = aws_vpc_endpoint.ie_rds.dns_entry[*].dns_name
}
