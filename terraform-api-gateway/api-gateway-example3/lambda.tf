################################################################################
# Compressing lambda function code
################################################################################
data "archive_file" "lambda_function_archive" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda_function.zip"
}

################################################################################
# Creating Lambda Function
################################################################################
resource "aws_lambda_function" "book_lambda_function" {
  function_name = "Books_Lambda"
  filename      = "${path.module}/lambda_function.zip"

  runtime     = "python3.13"
  handler     = "lambda_function.lambda_handler"
  memory_size = 128
  timeout     = 10

  environment {
    variables = {
      DYNAMODB_TABLE = "Books_Table"
    }
  }

  source_code_hash = data.archive_file.lambda_function_archive.output_base64sha256

  role = aws_iam_role.lambda_role.arn
}

################################################################################
# Creating CloudWatch Log group for Lambda Function
################################################################################
resource "aws_cloudwatch_log_group" "book_lambda_function_cloudwatch" {
  name              = "/aws/lambda/${aws_lambda_function.book_lambda_function.function_name}"
  retention_in_days = 30
}
