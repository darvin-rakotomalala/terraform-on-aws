output "api_gateway_invoke_url" {
  description = "The invoke URL of the API Gateway Stage"
  value       = "${aws_api_gateway_stage.my-dev-stage.invoke_url}/"
}

output "api_endpoint" {
  value       = "https://api.${var.domain_name}/"
  description = "The base URL of API Gateway. Use it to construct the full path to API resources."
}

output "auth_endpoint" {
  value       = "https://auth.${var.domain_name}/oauth2/token"
  description = "The base URL of Cognito. Use it to obtain the `access_token` with `?grant_type=client_credentials` authorization flow."
}
