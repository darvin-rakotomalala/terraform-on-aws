# outputs.tf
output "s3_gateway_endpoint_id" {
  description = "The ID of the S3 Gateway Endpoint"
  value       = aws_vpc_endpoint.s3_vpc_endpoint.id
}

output "s3_gateway_endpoint_service_name" {
  description = "The service name of the S3 Gateway Endpoint"
  value       = aws_vpc_endpoint.s3_vpc_endpoint.service_name
}

output "dynamodb_gateway_endpoint_id" {
  description = "The ID of the DynamoDB Gateway Endpoint"
  value       = aws_vpc_endpoint.dynamodb_vpc_endpoint.id
}

output "dynamodb_gateway_endpoint_service_name" {
  description = "The service name of the DynamoDB Gateway Endpoint"
  value       = aws_vpc_endpoint.dynamodb_vpc_endpoint.service_name
}
