output "my_user_pool_id" {
  description = "The ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.my_cognito_pool.id
}

output "my_client_id" {
  description = "The Client ID of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.my_userpool_client.id
}

output "tf_user_pool_id" {
  description = "The ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.my_cognito_pool.id
}

output "tf_client_id" {
  description = "The Client ID of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.my_userpool_client.id
}

output "tf_cognito_hosted_ui_url" {
  value = "https://${aws_cognito_user_pool_domain.user_pool_domain.domain}.auth.${aws_cognito_user_pool.tf_cognito_user_pool.region}.amazoncognito.com/oauth2/token"
}
