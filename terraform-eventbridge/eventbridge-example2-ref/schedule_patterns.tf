#########################################
## Schedule Patterns
#########################################

## Cron Expression
resource "aws_cloudwatch_event_rule" "cron" {
  name                = "${var.project_name}-cron"
  description         = "Run on specific schedule"
  event_bus_name      = aws_cloudwatch_event_bus.main.name
  schedule_expression = "cron(0 12 * * ? *)"
}

## Rate Expression
resource "aws_cloudwatch_event_rule" "rate" {
  name                = "${var.project_name}-rate"
  description         = "Run at regular intervals"
  event_bus_name      = aws_cloudwatch_event_bus.main.name
  schedule_expression = "rate(5 minutes)"
}
