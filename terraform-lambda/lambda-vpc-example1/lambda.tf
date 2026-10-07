# Lambda VPC Endpoint for DynamoDB
# The terraform command automatically creates prefix list in the private route table.
resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = aws_route_table.private[*].id
}

data "archive_file" "my_lambda_source_archive" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda_func.zip"
}

# Lambda Function
resource "aws_lambda_function" "lambda_function" {
  filename         = "${path.module}/lambda_func.zip" # Create this file with your Lambda code
  source_code_hash = data.archive_file.my_lambda_source_archive.output_base64sha256
  function_name    = var.func_name
  role             = aws_iam_role.lambda_role.arn
  handler          = "main.handler"
  runtime          = "python3.13"
  memory_size      = 512
  timeout          = 30

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/${var.func_name}-${var.stage}"
  }

  tracing_config {
    mode = "PassThrough"
  }

  ephemeral_storage {
    size = "512"
  }

  vpc_config {
    subnet_ids         = aws_subnet.private[*].id
    security_group_ids = [aws_security_group.lambda.id]
  }

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = aws_dynamodb_table.my_dynamodb_table.name
    }
  }
}

resource "aws_lambda_alias" "lambda_alias" {
  name             = var.stage
  function_name    = aws_lambda_function.lambda_function.function_name
  function_version = aws_lambda_function.lambda_function.version
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/${var.stage}/*"
}
