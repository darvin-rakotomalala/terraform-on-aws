output "api_gateway_invoke_url" {
  description = "The invoke URL of the API Gateway Stage"
  value       = "${aws_api_gateway_stage.my-dev-stage.invoke_url}/"
}

output "auth_endpoint" {
  description = "The base URL of Cognito. Use it to obtain the `access_token` with `?grant_type=client_credentials` authorization flow."
  value       = "https://${aws_cognito_user_pool_domain.user_pool_domain.domain}.auth.${aws_cognito_user_pool.my_cognito_user_pool.region}.amazoncognito.com/oauth2/token"
}
