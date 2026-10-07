module "lambda" {
  source        = "terraform-aws-modules/lambda/aws"
  function_name = "hello-lambda"
  description   = "My awesome lambda function"
  handler       = "hello.lambda_handler"
  runtime       = "python3.13"
  source_path   = "./hello.py"

  tags = {
    Name = "my-lambda-hello"
  }
}
