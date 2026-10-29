# Zip the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "rotation.py"
  output_path = "rotation.zip"
}

# IAM role for the Lambda function
resource "aws_iam_role" "rotation_lambda_role" {
  name = "SecretsManagerRotationLambdaRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
    }],
  })
}

# IAM policy for the Lambda function
resource "aws_iam_policy" "rotation_lambda_policy" {
  name = "SecretsManagerRotationLambdaPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecretVersionStage",
          "secretsmanager:GetRandomPassword",
        ],
        Resource = aws_secretsmanager_secret.example.arn,
      },
      {
        Effect   = "Allow",
        Action   = "logs:CreateLogGroup",
        Resource = "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:*",
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Resource = "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "rotation_lambda_policy_attachment" {
  role       = aws_iam_role.rotation_lambda_role.name
  policy_arn = aws_iam_policy.rotation_lambda_policy.arn
}

# The Lambda function resource
resource "aws_lambda_function" "rotation_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "SecretsManagerRotationLambda"
  role             = aws_iam_role.rotation_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.13"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# Allow Secrets Manager to invoke the Lambda function
resource "aws_lambda_permission" "allow_secrets_manager" {
  statement_id  = "AllowSecretsManagerInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rotation_lambda.function_name
  principal     = "secretsmanager.amazonaws.com"
  # Add the `aws:SourceAccount` condition to prevent the confused deputy problem
  # Source documentation: https://docs.aws.amazon.com
  source_account = data.aws_caller_identity.current.account_id
}

# The secret to be rotated
resource "aws_secretsmanager_secret" "example" {
  name = "example-rotated-secret"
}

# Enable rotation for the secret
resource "aws_secretsmanager_secret_rotation" "example_rotation" {
  secret_id           = aws_secretsmanager_secret.example.id
  rotation_lambda_arn = aws_lambda_function.rotation_lambda.arn

  rotation_rules {
    automatically_after_days = 30
  }
}

# Data sources to fetch current account and region info
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
