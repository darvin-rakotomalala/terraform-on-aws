# Create an IAM Role for CloudWatch Logging
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

# Attach the IAM Role ARN to the AWS API Gateway Account
resource "aws_api_gateway_account" "current_account_settings" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_cloudwatch_role.arn
}

# CloudWatch log group for api execution logs
resource "aws_cloudwatch_log_group" "api_gateway_execution_logs" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.API-gateway.id}/dev"
  retention_in_days = 7
}
