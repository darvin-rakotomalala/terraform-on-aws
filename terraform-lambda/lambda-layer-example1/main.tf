# main.tf
resource "aws_lambda_layer_version" "my_layer" {
  layer_name               = "my_lambda_layer"
  filename                 = "python.zip"
  compatible_architectures = ["x86_64"]
  compatible_runtimes      = ["python3.13"]
}

data "archive_file" "make_zip" {
  type        = "zip"
  source_file = "helloWorldPersonalized.py"
  output_path = "helloWorldPersonalized.zip"
}

resource "aws_lambda_function" "example_function" {
  function_name    = "lambda_layer_func"
  handler          = "helloWorldPersonalized.lambda_handler"
  runtime          = "python3.13"
  role             = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.make_zip.output_path
  source_code_hash = data.archive_file.make_zip.output_base64sha256
  layers           = [aws_lambda_layer_version.my_layer.arn]
  tags = {
    Environment = "dev"
    Application = "example-lambda_layer"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "my-first-tf-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "lambda" {
  name = "lambda-permissions"
  role = aws_iam_role.lambda_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
