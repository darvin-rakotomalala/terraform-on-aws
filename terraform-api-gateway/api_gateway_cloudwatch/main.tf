# 1. Create an IAM Role for CloudWatch Logging
resource "aws_iam_role" "api_gateway_cloudwatch_role" {
  name = "api_gateway_cloudwatch_logging_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "api_gateway_cloudwatch_policy" {
  role       = aws_iam_role.api_gateway_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

# 2. Attach the IAM Role ARN to the AWS API Gateway Account
resource "aws_api_gateway_account" "current" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_cloudwatch_role.arn
}

# 3. Enable CloudWatch Logging on the aws_api_gateway_stage
resource "aws_api_gateway_rest_api" "example" {
  name        = "MyApi"
  description = "Example API"
}

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.example.body))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  deployment_id = aws_api_gateway_deployment.example.id
  stage_name    = "dev"

  # depends_on = [aws_cloudwatch_log_group.api_gateway_log_group]

  /*access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_log_group.arn
    format = jsonencode({
      requestId      = "$context.requestId"
      ip             = "$context.identity.sourceIp"
      caller         = "$context.identity.caller"
      user           = "$context.identity.user"
      requestTime    = "$context.requestTime"
      httpMethod     = "$context.httpMethod"
      resourcePath   = "$context.resourcePath"
      status         = "$context.status"
      protocol       = "$context.protocol"
      responseLength = "$context.responseLength"
    })
  }*/

  variables = {
    log_level = "INFO" # Or "ERROR"
  }

  # Enable execution logging
  xray_tracing_enabled  = true  # Optional: Enable X-Ray tracing
  cache_cluster_enabled = false # Example: disable caching
}

resource "aws_cloudwatch_log_group" "api_gateway_log_group" {
  name              = "/aws/api-gateway/${aws_api_gateway_rest_api.example.name}/${aws_api_gateway_stage.example.stage_name}"
  retention_in_days = 7 # Example: retain logs for 7 days
}
