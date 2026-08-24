# Output the API Gateway URL
output "api_url" {
  value = "${aws_api_gateway_stage.my-prod-stage.invoke_url}/"
}
