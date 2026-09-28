##########################################
## Event Patterns
##########################################

## EC2 State Changes
resource "aws_cloudwatch_event_rule" "ec2_state" {
  name           = "${var.project_name}-ec2-state"
  description    = "Track EC2 state changes"
  event_bus_name = aws_cloudwatch_event_bus.main.name

  event_pattern = jsonencode({
    source      = ["aws.ec2"]
    detail-type = ["EC2 Instance State-change Notification"]
    detail = {
      state = ["running", "stopped", "terminated"]
    }
  })
}

## S3 Events
resource "aws_cloudwatch_event_rule" "s3_events" {
  name           = "${var.project_name}-s3-events"
  description    = "Track S3 object events"
  event_bus_name = aws_cloudwatch_event_bus.main.name

  event_pattern = jsonencode({
    source      = ["aws.s3"]
    detail-type = ["AWS API Call via CloudTrail"]
    detail = {
      eventSource = ["s3.amazonaws.com"]
      eventName   = ["PutObject", "DeleteObject"]
    }
  })
}

## Custom Events
resource "aws_cloudwatch_event_rule" "custom" {
  name           = "${var.project_name}-custom"
  description    = "Handle custom application events"
  event_bus_name = aws_cloudwatch_event_bus.main.name

  event_pattern = jsonencode({
    source      = ["custom.myapp"]
    detail-type = ["UserSignup", "OrderPlaced"]
    detail = {
      status = ["success", "failure"]
    }
  })
}
