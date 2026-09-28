#########################################
## Input Transformation
#########################################

## JSON Path
resource "aws_cloudwatch_event_target" "transform" {
  rule           = aws_cloudwatch_event_rule.pattern.name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  target_id      = "TransformInput"
  arn            = aws_lambda_function.handler.arn

  input_transformer {
    input_paths = {
      instance = "$.detail.instance-id"
      state    = "$.detail.state"
      time     = "$.time"
    }
    input_template = <<EOF
      {
        "instanceId": <instance>,
        "currentState": <state>,
        "timestamp": <time>
      }
    EOF
  }
}
