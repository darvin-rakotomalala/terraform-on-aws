output "api_gateway_invoke_url" {
  description = "The invoke URL of the API Gateway Stage"
  value       = "${aws_api_gateway_stage.my_dev_stage.invoke_url}/demo-path"
}

output "my_user_pool_id" {
  description = "The ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.my_cognito_pool.id
}

output "my_client_id" {
  description = "The Client ID of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.my_userpool_client.id
}
