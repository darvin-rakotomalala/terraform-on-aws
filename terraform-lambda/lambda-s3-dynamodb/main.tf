# 1. AWS S3 Bucket
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my-bucket-for-events-69127"
}

# 2. AWS DynamoDB Table
resource "aws_dynamodb_table" "my_dynamodb_table" {
  name         = "MyS3EventData"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id" # Example primary key

  attribute {
    name = "id"
    type = "S"
  }
}

# 3. AWS IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_s3_dynamodb_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# 4. AWS IAM Policy for Lambda
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_s3_dynamodb_policy"
  description = "IAM policy for Lambda to access S3 events and DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem"
        ],
        Effect   = "Allow",
        Resource = aws_dynamodb_table.my_dynamodb_table.arn
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

data "archive_file" "my_lambda_source_archive" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda_func.zip"
}

# 5. AWS Lambda Function
resource "aws_lambda_function" "s3_event_processor" {
  function_name = "s3_event_processor"
  handler       = "main.handler" # Assuming Python and a file named main.py with a handler function
  runtime       = "python3.13"
  role          = aws_iam_role.lambda_exec_role.arn
  timeout       = 30

  # Example: inline code for simplicity, in production, use a zip file
  filename         = "${path.module}/lambda_func.zip" # Create this file with your Lambda code
  source_code_hash = data.archive_file.my_lambda_source_archive.output_base64sha256

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = aws_dynamodb_table.my_dynamodb_table.name
    }
  }
}

# 6. AWS S3 Bucket Notification
resource "aws_s3_bucket_notification" "s3_notification_to_lambda" {
  bucket = aws_s3_bucket.my_s3_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_event_processor.arn
    events              = ["s3:ObjectCreated:*"] # Trigger on object creation
  }
}

# 7. AWS Lambda Permission for S3 to invoke the function
resource "aws_lambda_permission" "allow_s3_to_invoke_lambda" {
  statement_id  = "AllowS3InvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_event_processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.my_s3_bucket.arn
}
