resource "aws_lambda_function" "lambda" {
  function_name                  = "${var.name}-lambda"
  filename                       = data.archive_file.lambda_zip.output_path
  source_code_hash               = data.archive_file.lambda_zip.output_base64sha256
  role                           = aws_iam_role.lambda_role.arn
  handler                        = "lambda_function.lambda_handler"
  runtime                        = "python3.12"
  timeout                        = 30
  memory_size                    = 128
  kms_key_arn                    = aws_kms_key.lambda_key.arn
  # reserved_concurrent_executions = 10
  logging_config {
    log_format = "JSON"
    log_group  = aws_cloudwatch_log_group.lambda_log.name
  }

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }

  depends_on = [
    aws_kms_key_policy.lambda_key,
    aws_kms_key_policy.encrypt_cloudwatch
  ]
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda_function.zip"
  source {
    content  = file("${path.module}/lambda_function.py")
    filename = "lambda_function.py"
  }
}
