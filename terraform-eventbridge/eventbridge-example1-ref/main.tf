data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# default event bus
data "aws_cloudwatch_event_bus" "default" {
  name = "default"
}

/*
# Custom event bus
resource "aws_cloudwatch_event_bus" "test_bus" {
  name = "test-custom-bus-69127"
}
*/

######################################################
## S3 Bucket
######################################################
resource "aws_s3_bucket" "eventbridge" {
  bucket        = "default-event-bus-69127"
  force_destroy = true
}

resource "aws_s3_bucket_notification" "s3_eventbridge" {
  bucket      = aws_s3_bucket.eventbridge.bucket
  eventbridge = true
}

######################################################
# EventBridge rules
######################################################
resource "aws_cloudwatch_event_rule" "s3_createobject" {
  name           = "s3_createobjectevent_rule_69127"
  description    = "Rule to trigger when an object is created in the S3 bucket"
  event_bus_name = data.aws_cloudwatch_event_bus.default.name


  event_pattern = jsonencode({
    source      = ["aws.s3"],
    detail-type = ["Object Created"],
    detail = {
      bucket = {
        name = ["${aws_s3_bucket.eventbridge.bucket}"]
      }
    }
  })
}

/*
######################################################
# Scheduler rule
######################################################
resource "aws_cloudwatch_event_rule" "scheduler" {
  name                = "every_minute_test_schulder_69127"
  description         = "Rule to trigger every minute"
  event_bus_name      = data.aws_cloudwatch_event_bus.default.name
  schedule_expression = "cron(* * * * ? *)" // Triggers every minute, could also be rate(1 minute)
}
*/

/*
######################################################
# Schedule using EventBridge Scheduler
######################################################
resource "aws_scheduler_schedule" "better_scheduler" {
  name = "better_scheduler_69127"
  flexible_time_window {
    mode = "OFF"
  }
  target {
    arn      = data.aws_cloudwatch_event_bus.default.arn
    role_arn = aws_iam_role.scheduler.arn
    eventbridge_parameters {
      detail_type = "My Scheduler"
      source      = "Custom Scheduler"
    }

    // Event Payload (if required)
    input = jsonencode({
      Message = "Super Schedule"
    })
  }
  schedule_expression = "cron(* * * * ? *)" // Triggers every minute, could also be rate(1 minute)
}

resource "aws_iam_role" "scheduler" {
  name               = "scheduler_role_69127"
  assume_role_policy = data.aws_iam_policy_document.eventbridge_assume_policy.json
}

data "aws_iam_policy_document" "eventbridge_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "scheduler_policies" {
  statement {
    effect  = "Allow"
    actions = ["events:PutEvents"]

    resources = [
      data.aws_cloudwatch_event_bus.default.arn
    ]
  }
}

resource "aws_iam_role_policy" "scheduler_role_policy" {
  role   = aws_iam_role.scheduler.name
  policy = data.aws_iam_policy_document.scheduler_policies.json
}
*/
