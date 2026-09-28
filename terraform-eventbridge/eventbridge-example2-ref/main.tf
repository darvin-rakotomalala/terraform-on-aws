############################################
## EventBridge Configuration
############################################
# Event Bus
resource "aws_cloudwatch_event_bus" "main" {
  name = "${var.project_name}-bus"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-bus"
    }
  )
}

# Event Bus Policy
resource "aws_cloudwatch_event_bus_policy" "main" {
  event_bus_name = aws_cloudwatch_event_bus.main.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowOtherAccountsPutEvents"
        Effect = "Allow"
        Principal = {
          AWS = var.allowed_account_ids
        }
        Action   = "events:PutEvents"
        Resource = aws_cloudwatch_event_bus.main.arn
      }
    ]
  })
}

# Schedule Rule
resource "aws_cloudwatch_event_rule" "schedule" {
  name                = "${var.project_name}-schedule"
  description         = "Schedule-based rule"
  event_bus_name      = aws_cloudwatch_event_bus.main.name
  schedule_expression = "rate(5 minutes)"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-schedule"
    }
  )
}

# Pattern-based Rule
resource "aws_cloudwatch_event_rule" "pattern" {
  name           = "${var.project_name}-pattern"
  description    = "Pattern-based rule"
  event_bus_name = aws_cloudwatch_event_bus.main.name

  event_pattern = jsonencode({
    source      = ["aws.ec2"]
    detail-type = ["EC2 Instance State-change Notification"]
    detail = {
      state = ["running", "stopped"]
    }
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-pattern"
    }
  )
}

# Lambda Target
resource "aws_cloudwatch_event_target" "lambda" {
  rule           = aws_cloudwatch_event_rule.pattern.name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  target_id      = "SendToLambda"
  arn            = aws_lambda_function.handler.arn

  retry_policy {
    maximum_event_age_in_seconds = 3600
    maximum_retry_attempts       = 3
  }

  dead_letter_config {
    arn = aws_sqs_queue.dlq.arn
  }
}

# SQS Target
resource "aws_cloudwatch_event_target" "sqs" {
  rule           = aws_cloudwatch_event_rule.schedule.name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  target_id      = "SendToSQS"
  arn            = aws_sqs_queue.main.arn

  input_transformer {
    input_paths = {
      time = "$.time"
      id   = "$.id"
    }
    input_template = <<EOF
    {
      "timestamp" : <time>,
      "event_id": <id>
    }
    EOF
  }
}

# SNS Target
resource "aws_cloudwatch_event_target" "sns" {
  rule           = aws_cloudwatch_event_rule.pattern.name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  target_id      = "SendToSNS"
  arn            = aws_sns_topic.notifications.arn

  input_path = "$.detail"
}

# Step Functions Target
resource "aws_cloudwatch_event_target" "step_functions" {
  rule           = aws_cloudwatch_event_rule.pattern.name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  target_id      = "SendToStepFunctions"
  arn            = aws_sfn_state_machine.main.arn
  role_arn       = aws_iam_role.events.arn
}

# Kinesis Target
resource "aws_cloudwatch_event_target" "kinesis" {
  rule           = aws_cloudwatch_event_rule.pattern.name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  target_id      = "SendToKinesis"
  arn            = aws_kinesis_stream.main.arn
  role_arn       = aws_iam_role.events.arn

  kinesis_target {
    partition_key_path = "$.id"
  }
}

# API Destination Target
resource "aws_cloudwatch_event_api_destination" "webhook" {
  name                             = "${var.project_name}-webhook"
  description                      = "Webhook destination"
  invocation_endpoint              = "https://api.example.com/webhook"
  http_method                      = "POST"
  invocation_rate_limit_per_second = 10
  connection_arn                   = aws_cloudwatch_event_connection.webhook.arn
}

resource "aws_cloudwatch_event_connection" "webhook" {
  name               = "${var.project_name}-webhook-connection"
  description        = "Webhook connection"
  authorization_type = "API_KEY"

  auth_parameters {
    api_key {
      key   = "Authorization"
      value = var.webhook_api_key
    }
  }
}

resource "aws_cloudwatch_event_target" "api_destination" {
  rule           = aws_cloudwatch_event_rule.pattern.name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  target_id      = "SendToWebhook"
  arn            = aws_cloudwatch_event_api_destination.webhook.arn
  role_arn       = aws_iam_role.events.arn
}
