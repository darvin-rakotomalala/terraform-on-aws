# API Gateway
resource "aws_api_gateway_rest_api" "crud_api" {
  name        = "crud-api"
  description = "CRUD API Gateway"
}

# API Gateway resource
resource "aws_api_gateway_resource" "items" {
  rest_api_id = aws_api_gateway_rest_api.crud_api.id
  parent_id   = aws_api_gateway_rest_api.crud_api.root_resource_id
  path_part   = "items"
}

# GET method
resource "aws_api_gateway_method" "get" {
  rest_api_id   = aws_api_gateway_rest_api.crud_api.id
  resource_id   = aws_api_gateway_resource.items.id
  http_method   = "GET"
  authorization = "NONE"
}

# POST method
resource "aws_api_gateway_method" "post" {
  rest_api_id   = aws_api_gateway_rest_api.crud_api.id
  resource_id   = aws_api_gateway_resource.items.id
  http_method   = "POST"
  authorization = "NONE"
}

# PUT method
resource "aws_api_gateway_method" "put" {
  rest_api_id   = aws_api_gateway_rest_api.crud_api.id
  resource_id   = aws_api_gateway_resource.items.id
  http_method   = "PUT"
  authorization = "NONE"
}

# DELETE method
resource "aws_api_gateway_method" "delete" {
  rest_api_id   = aws_api_gateway_rest_api.crud_api.id
  resource_id   = aws_api_gateway_resource.items.id
  http_method   = "DELETE"
  authorization = "NONE"
}

# Lambda integration for GET
resource "aws_api_gateway_integration" "lambda_get" {
  rest_api_id = aws_api_gateway_rest_api.crud_api.id
  resource_id = aws_api_gateway_resource.items.id
  http_method = aws_api_gateway_method.get.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.crud_lambda.invoke_arn
}

# Lambda integration for POST
resource "aws_api_gateway_integration" "lambda_post" {
  rest_api_id = aws_api_gateway_rest_api.crud_api.id
  resource_id = aws_api_gateway_resource.items.id
  http_method = aws_api_gateway_method.post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.crud_lambda.invoke_arn
}

# Lambda integration for PUT
resource "aws_api_gateway_integration" "lambda_put" {
  rest_api_id = aws_api_gateway_rest_api.crud_api.id
  resource_id = aws_api_gateway_resource.items.id
  http_method = aws_api_gateway_method.put.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.crud_lambda.invoke_arn
}

# Lambda integration for DELETE
resource "aws_api_gateway_integration" "lambda_delete" {
  rest_api_id = aws_api_gateway_rest_api.crud_api.id
  resource_id = aws_api_gateway_resource.items.id
  http_method = aws_api_gateway_method.delete.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.crud_lambda.invoke_arn
}

# API Gateway deployment
resource "aws_api_gateway_deployment" "crud_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_get,
    aws_api_gateway_integration.lambda_post,
    aws_api_gateway_integration.lambda_put,
    aws_api_gateway_integration.lambda_delete
  ]

  rest_api_id = aws_api_gateway_rest_api.crud_api.id
}

# API Gateway stage
resource "aws_api_gateway_stage" "crud_stage" {
  deployment_id = aws_api_gateway_deployment.crud_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.crud_api.id
  stage_name    = "dev"
}
