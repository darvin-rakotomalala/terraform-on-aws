####################################################
## Dashboards
####################################################
resource "aws_cloudwatch_dashboard" "main_dashboard" {
  dashboard_name = "MyDashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        properties = {
          title   = "Lambda Invocations",
          metrics = [["AWS/Lambda", "Invocations", "FunctionName", "my_lambda_function"]],
          period  = 60,
          stat    = "Sum"
        }
      },
      {
        type = "metric",
        properties = {
          title   = "API Gateway Latency",
          metrics = [["AWS/ApiGateway", "Latency", "ApiName", "my_api_gateway"]],
          period  = 60,
          stat    = "Average"
        }
      }
    ]
  })
}
