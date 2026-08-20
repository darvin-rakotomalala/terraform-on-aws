# Use the endpoint as an environment variable in your Lambda function
output "dynamodb_vpc_endpoint_dns" {
  value = aws_vpc_endpoint.dynamodb.dns_entry[0].dns_name
}
