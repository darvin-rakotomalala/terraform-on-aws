#1 Create Lambda Function
data "archive_file" "lambda_zip_file" {
  type        = "zip"
  source_file = "lambda/index.js"
  output_path = "lambda/index.zip"
}

resource "aws_iam_role_policy_attachment" "lambda_exec_role_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "my_lambda_function" {
  filename         = "lambda/index.zip"
  function_name    = "Demo_HTTP_API_LambdaFunction"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "index.handler"
  runtime          = "nodejs24.x"
  timeout          = 30
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256

  environment {
    variables = {
      VIDEO_NAME = "Lambda Terraform Demo"
    }
  }
}

# Define the IAM policy for CloudWatch logging
# 1. Define the IAM policy document for logging permissions
data "aws_iam_policy_document" "lambda_logging_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    # Restricts the permissions to only the specific log group for this function
    resources = ["${aws_cloudwatch_log_group.function_log_group.arn}:*"]
    effect    = "Allow"
  }
}

# 2. Create the IAM policy resource
resource "aws_iam_policy" "lambda_logging_policy" {
  name        = "lambda-logging-policy"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_logging_policy.json
}

# 3. Define the IAM assume role policy for the Lambda service
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# 4. Create the IAM role
resource "aws_iam_role" "lambda_exec_role" {
  name               = "function-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# 5. Attach the logging policy to the role
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}


# 6. Explicitly create the CloudWatch Log Group with a retention period
# The name must follow the specific AWS pattern: /aws/lambda/<function-name>
resource "aws_cloudwatch_log_group" "function_log_group" {
  name = "/aws/lambda/${aws_lambda_function.my_lambda_function.function_name}"
  # Retain logs for 7 days (optional, can be any valid retention period)
  retention_in_days = 7
}

/*
resource "aws_lambda_permission" "allow_api_gw_invoke_authorizer" {
  statement_id  = "allowInvokeFromAPIGatewayAuthorizer"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this.execution_arn}/authorizers/${aws_apigatewayv2_authorizer.header_based_authorizer.id}"
}
*/
