# Output the API Gateway URL
output "api_url" {
  value = "${aws_api_gateway_stage.crud_stage.invoke_url}/items"
}
