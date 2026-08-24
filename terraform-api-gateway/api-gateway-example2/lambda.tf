data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "index.py"
  output_path = "lambda_function.zip"
}

# Lambda function
resource "aws_lambda_function" "crud_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "crud_operations"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "python3.13"
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
}

# Lambda permission for API Gateway
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.crud_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.crud_api.execution_arn}/*/*"
}
