################################################################################
# Compressing lambda_handler function code
################################################################################
data "archive_file" "my_lambda_source_archive" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda_func.zip"
}

################################################################################
# Creating Lambda Function
################################################################################
resource "aws_lambda_function" "my_lambda_function" {
  function_name = "EventLambdaFunction"
  filename      = "${path.module}/lambda_func.zip"

  runtime     = "python3.13"
  handler     = "main.lambda_handler"
  memory_size = 256
  timeout     = 300

  environment {
    variables = {
      SOURCE_BUCKET = aws_s3_bucket.source-image-bucket.bucket
    }
  }

  source_code_hash = data.archive_file.my_lambda_source_archive.output_base64sha256
  role             = aws_iam_role.lambda_s3_role.arn
}

################################################################################
# Lambda Function Permission to have S3 as a Trigger for Lambda Function
################################################################################
resource "aws_lambda_permission" "allow_exec_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda_function.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.source-image-bucket.arn
}

################################################################################
# Creating S3 Notification for Lambda when Object is uploaded in the Source Bucket
################################################################################
resource "aws_s3_bucket_notification" "thumbnail_notification" {
  bucket = aws_s3_bucket.source-image-bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.my_lambda_function.arn
    events              = ["s3:ObjectCreated:*"]
  }
  depends_on = [
    aws_lambda_permission.allow_exec_bucket
  ]
}

################################################################################
# Creating CloudWatch Log group for Lambda Function
################################################################################
resource "aws_cloudwatch_log_group" "logs_lambda_func_cloudwatch" {
  name              = "/aws/lambda/${aws_lambda_function.my_lambda_function.function_name}"
  retention_in_days = 30
}
