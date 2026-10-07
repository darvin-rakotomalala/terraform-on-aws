data "archive_file" "make_zip" {
  type        = "zip"
  source_file = "check_running_instance.py"
  output_path = "check_running_instance.zip"
}

resource "aws_lambda_function" "my_lambda_function" {
  function_name    = "check_running_instance"
  filename         = data.archive_file.make_zip.output_path
  source_code_hash = data.archive_file.make_zip.output_base64sha256
  role             = aws_iam_role.lambda_iam_role.arn
  handler          = "check_running_instance.lambda_handler"
  runtime          = "python3.13"

  memory_size = 512
  timeout     = 30

  architectures = ["arm64"] # Graviton support for better price/performance

  environment {
    variables = {
      ENVIRONMENT = "dev"
      LOG_LEVEL   = "info"
    }
  }

  tags = {
    Environment = "dev"
    Application = "example"
  }
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name      = aws_lambda_function.my_lambda_function.function_name
  authorization_type = "NONE"
  cors {
    allow_origins = ["*"]
  }
}

output "lambda_function_arn" {
  description = "The ARN of the deployed Lambda function"
  value       = aws_lambda_function.my_lambda_function.arn
}

output "function_url" {
  description = "The function URL of the deployed Lambda"
  value       = aws_lambda_function_url.lambda_url.function_url
}
