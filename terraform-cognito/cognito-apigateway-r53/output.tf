# Output the domain name for verification
output "api_gateway_custom_domain" {
  value       = "https://${aws_api_gateway_domain_name.example.domain_name}"
  description = "The custom domain name of the API Gateway"
}

# Output the ARN of the custom domain name
output "api_gateway_domain_name_arn" {
  description = "ARN of the custom domain name"
  value       = aws_api_gateway_domain_name.example.arn
}
