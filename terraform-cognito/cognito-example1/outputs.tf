# Output User Pool and Client IDs
output "user_pool_id" {
  value = aws_cognito_user_pool.main_user_pool.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.client.id
}

# Output the Hosted UI URL for easy access
output "cognito_hosted_ui_url" {
  value = "https://${aws_cognito_user_pool_domain.cognito_domain.domain}.auth.${aws_cognito_user_pool.main_user_pool.region}.amazoncognito.com/login?client_id=${aws_cognito_user_pool_client.client.id}&response_type=code&scope=email+openid+profile&redirect_uri=https://cloudwithdarvin.com/callback"
}
