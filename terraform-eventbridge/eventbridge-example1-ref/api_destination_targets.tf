/*
#################################################
## API Destinations
#################################################
resource "aws_cloudwatch_event_connection" "api" {
  name               = "TestConnection"
  authorization_type = "API_KEY"
  auth_parameters {
    api_key {
      key   = "X-API-Key"
      value = "DummyValue"
    }
  }
}

resource "aws_cloudwatch_event_api_destination" "api" {
  name                = "TestAPIDestination"
  connection_arn      = aws_cloudwatch_event_connection.api.arn
  http_method         = "GET"
  invocation_endpoint = "https://example.com"
}
*/
