data "archive_file" "make_zip" {
  type        = "zip"
  source_file = "rotation.py"
  output_path = "rotation.zip"
}

resource "aws_lambda_function" "rotation_lambda" {
  # filename         = "lambda_rotation.zip" # Path to your zip file
  filename         = data.archive_file.make_zip.output_path
  function_name    = "SecretRotationFunction"
  role             = aws_iam_role.lambda_rotation_role.arn
  handler          = "rotation.lambda_handler"
  runtime          = "python3.13"
  source_code_hash = data.archive_file.make_zip.output_base64sha256

  memory_size   = 512
  timeout       = 30
  architectures = ["arm64"] # Graviton support for better price/performance

  environment {
    variables = {
      SECRET_ARN  = aws_secretsmanager_secret.application_secret.arn
      ENVIRONMENT = "dev"
      LOG_LEVEL   = "info"
    }
  }
}
