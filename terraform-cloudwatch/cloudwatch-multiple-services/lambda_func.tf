resource "aws_lambda_function" "metadata_logger" {
  function_name = "MetadataLoggerLambda"
  role          = aws_iam_role.lambda_exec.arn
  runtime       = "python3.9"
  handler       = "index.lambda_handler"
  filename      = "lambda.zip"

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
    }
  }
}
