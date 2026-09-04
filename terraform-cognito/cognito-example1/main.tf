# Create a Cognito User Pool
resource "aws_cognito_user_pool" "main_user_pool" {
  name = "terraform-user-pool"

  # Optional: Enforce sign-in via email instead of a separate username
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  # Password policy
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = true
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Account Confirmation"
    email_message        = "Your confirmation code is {####}"
  }

  # Custom attributes with shorter names
  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }

  # Tags for resources
  tags = {
    Environment = var.environment
  }
}

# Create a User Pool Client for the application
resource "aws_cognito_user_pool_client" "client" {
  name         = "terraform-user-pool-client"
  user_pool_id = aws_cognito_user_pool.main_user_pool.id

  # Required to use the Hosted UI OAuth flows
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  supported_identity_providers         = ["COGNITO"] # Use Cognito's built-in provider

  # Define the URLs where users are redirected after sign-in/sign-out
  callback_urls = ["https://cloudwithdarvin.com/callback"]
  logout_urls   = ["https://cloudwithdarvin.com/signout"]
}

# Domain Configuration
# Define a domain for the Hosted UI
resource "aws_cognito_user_pool_domain" "cognito_domain" {
  domain       = var.domain_prefix
  user_pool_id = aws_cognito_user_pool.main_user_pool.id
}

# Resource Server
resource "aws_cognito_resource_server" "resource_server" {
  name         = "${var.project_name}-resource-server"
  identifier   = "myapi"
  user_pool_id = aws_cognito_user_pool.main_user_pool.id

  scope {
    scope_name        = "all"
    scope_description = "Get access to all API Gateway endpoints."
  }
  /*
    scope {
      scope_name        = "read"
      scope_description = "Read access"
    }

    scope {
      scope_name        = "write"
      scope_description = "Write access"
    }
   */
}
