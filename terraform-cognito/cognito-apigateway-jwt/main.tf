### Cognito
resource "aws_cognito_user_pool" "pool" {
  name = "example_user_pool"
  password_policy {
    minimum_length    = 8
    require_lowercase = false
    require_uppercase = false
    require_numbers   = false
    require_symbols   = false
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name         = "example_external_api"
  user_pool_id = aws_cognito_user_pool.pool.id
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
}

resource "aws_cognito_user" "my_user" {
  user_pool_id = aws_cognito_user_pool.pool.id
  username     = var.username
  password     = var.password
}

# Configure the AWS provider
# Create the API Gateway v2 (HTTP API)
resource "aws_apigatewayv2_api" "example_api" {
  name          = "example-jwt-api"
  protocol_type = "HTTP"
}

# Define the JWT Authorizer
# Replace 'YOUR_ISSUER_URL' and 'YOUR_AUDIENCE_LIST' with your IdP's details.
resource "aws_apigatewayv2_authorizer" "example_authorizer" {
  name             = "example-jwt-authorizer"
  api_id           = aws_apigatewayv2_api.example_api.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"] # JWT token location in the request

  jwt_configuration {
    # The base domain of the identity provider (e.g., https://cognito-idp.us-east-1.amazonaws.com)
    issuer = "https://${aws_cognito_user_pool.pool.endpoint}"
    # issuer   = "https://cognito-idp.${var.aws_region}.amazonaws.com/${var.user_pool_id}"
    # A list of the intended recipients of the JWT (e.g., ["your-client-id"])
    audience = [aws_cognito_user_pool_client.client.id]
  }
}

# Define the backend integration (e.g., a Lambda function or HTTP endpoint)
# This example assumes a simple mock integration, but you would replace this with
# your actual backend logic (e.g., aws_lambda_function or another HTTP service).
resource "aws_apigatewayv2_integration" "example_integration" {
  api_id                 = aws_apigatewayv2_api.example_api.id
  integration_type       = "AWS_PROXY" # Use "AWS_PROXY" for Lambda, "HTTP_PROXY" for URLs
  integration_method     = "POST"
  connection_type        = "INTERNET"
  integration_uri        = aws_lambda_function.my_lambda_function.arn
  payload_format_version = "2.0"
}

resource "aws_lambda_permission" "apigw_lambda_permission" {
  statement_id  = "allowInvokeFromAPIGatewayRoute"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.example_api.execution_arn}/*/*/*"
}

# Create an API Gateway Route and link the Authorizer
resource "aws_apigatewayv2_route" "example_route" {
  api_id    = aws_apigatewayv2_api.example_api.id
  route_key = "GET /example"
  target    = "integrations/${aws_apigatewayv2_integration.example_integration.id}"
  # Apply the JWT authorizer
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.example_authorizer.id
  # (Optional) Specify required scopes if your IdP uses them
  # authorization_scopes = ["scope1", "scope2"]
}

resource "aws_apigatewayv2_deployment" "example" {
  api_id      = aws_apigatewayv2_api.example_api.id
  description = "Example deployment"

  triggers = {
    redeployment = sha1(join(",", tolist([
      jsonencode(aws_apigatewayv2_integration.example_integration),
      jsonencode(aws_apigatewayv2_route.example_route),
    ])))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Deploy the API to a stage (e.g., "prod")
resource "aws_apigatewayv2_stage" "example_stage" {
  api_id      = aws_apigatewayv2_api.example_api.id
  name        = "dev"
  auto_deploy = true
  description = "Default stage (i.e., Production mode)"

  default_route_settings {
    throttling_burst_limit = 1
    throttling_rate_limit  = 1
  }

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.cloudwatch.arn
    format = jsonencode({
      authorizerError           = "$context.authorizer.error",
      identitySourceIP          = "$context.identity.sourceIp",
      integrationError          = "$context.integration.error",
      integrationErrorMessage   = "$context.integration.errorMessage"
      integrationLatency        = "$context.integration.latency",
      integrationRequestId      = "$context.integration.requestId",
      integrationStatus         = "$context.integration.integrationStatus",
      integrationStatusCode     = "$context.integration.status",
      requestErrorMessage       = "$context.error.message",
      requestErrorMessageString = "$context.error.messageString",
      requestId                 = "$context.requestId",
      routeKey                  = "$context.routeKey",
    })
  }
}

resource "aws_api_gateway_account" "this" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_cloudwatch_logs.arn
  # Explicit dependency to prevent race condition
  depends_on = [aws_iam_role_policy_attachment.attach_cloudwatch_logging]
}

resource "aws_iam_role" "api_gateway_cloudwatch_logs" {
  name = "api-gateway-cloudwatch-logs"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_logging" {
  role       = aws_iam_role.api_gateway_cloudwatch_logs.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_cloudwatch_log_group" "cloudwatch" {
  name              = "/aws/api-gw/${aws_apigatewayv2_api.example_api.name}"
  log_group_class   = "STANDARD"
  retention_in_days = 14
}

# Output the API endpoint URL
output "api_endpoint" {
  value = aws_apigatewayv2_api.example_api.api_endpoint
}

output "user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.client.id
}
