# IAM role for AWS Lambda
resource "aws_iam_role" "terraform_lambda_iam_role" {
  name               = var.terraform_lambda_iam_role.name
  assume_role_policy = var.terraform_lambda_iam_role.assume_role_policy
}

# Create a new policy for Lambda
resource "aws_iam_policy" "iam_policy_for_lambda" {
  name        = "iam_policy_${var.terraform_lambda_iam_role.name}"
  description = var.iam_policy_for_lambda.description
  policy      = var.iam_policy_for_lambda.policy
}

# Attach IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.terraform_lambda_iam_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

# Create a zip file for upload to Lambda
data "archive_file" "zip_python_lambda_code" {
  type        = "zip"
  output_path = "${path.module}/python/${var.zip_python_lambda_code.name}.zip"
  source_file = "${path.module}/python/${var.zip_python_lambda_code.name}.py"
}

# Create the Lambda function
resource "aws_lambda_function" "terraform_lambda" {
  filename      = "${path.module}/python/${var.zip_python_lambda_code.name}.zip"
  function_name = var.terraform_lambda.name
  role          = aws_iam_role.terraform_lambda_iam_role.arn
  runtime       = var.terraform_lambda.runtime
  handler       = "${var.zip_python_lambda_code.name}.lambda_handler"
}
