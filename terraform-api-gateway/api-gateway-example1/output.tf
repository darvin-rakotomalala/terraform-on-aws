output "api_gateway_url" {
  description = "The invoke URL of the API Gateway"
  value       = aws_api_gateway_stage.my_api_stage.invoke_url
}
