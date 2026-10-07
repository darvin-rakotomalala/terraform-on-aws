################################################################################
# Creating lambda layer for requests python library
################################################################################
resource "aws_lambda_layer_version" "requests_layer" {
  filename            = "${path.module}/requests_layer.zip"
  layer_name          = "requests_layer"
  compatible_runtimes = ["python3.13"]
  source_code_hash    = filebase64sha256("${path.module}/requests_layer.zip")
}

################################################################################
# Compressing lambda_handler function code
################################################################################
data "archive_file" "lambda_function_archive" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda_function.zip"
}

################################################################################
# Creating Lambda Function
################################################################################
resource "aws_lambda_function" "get_joke_lambda_function" {
  function_name = "ChuckNorrisJokes_Lambda"
  filename      = "${path.module}/lambda_function.zip"

  runtime     = "python3.13"
  handler     = "chucknorris_jokes.lambda_handler"
  layers      = [aws_lambda_layer_version.requests_layer.arn]
  memory_size = 128
  timeout     = 10

  environment {
    variables = {
      API_URL = "https://api.chucknorris.io/jokes/random"
    }
  }

  source_code_hash = data.archive_file.lambda_function_archive.output_base64sha256

  role = aws_iam_role.lambda_role.arn
}

################################################################################
# Creating Lambda Function URL for accessing it via browser
################################################################################
resource "aws_lambda_function_url" "chucknorris_function_url" {
  function_name      = aws_lambda_function.get_joke_lambda_function.function_name
  authorization_type = "NONE" # Change to "AWS_IAM" for restricted access
  cors {
    allow_origins = ["*"]
  }
}

################################################################################
# Creating CloudWatch Log group for Lambda Function
################################################################################
resource "aws_cloudwatch_log_group" "get_joke_lambda_function_cloudwatch" {
  name              = "/aws/lambda/${aws_lambda_function.get_joke_lambda_function.function_name}"
  retention_in_days = 30
}
