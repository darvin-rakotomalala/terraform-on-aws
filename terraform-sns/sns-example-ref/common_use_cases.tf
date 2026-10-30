################################################
### Event Notification System
################################################
resource "aws_sns_topic" "events" {
  name = "${var.project_name}-events"
}

resource "aws_sns_topic_subscription" "events_email" {
  count     = length(var.notification_emails)
  topic_arn = aws_sns_topic.events.arn
  protocol  = "email"
  endpoint  = var.notification_emails[count.index]
}

################################################
### Multi-Region Fanout
################################################
resource "aws_sns_topic" "primary" {
  name = "${var.project_name}-primary"
}

resource "aws_sns_topic" "secondary" {
  provider = aws.secondary_region
  name     = "${var.project_name}-secondary"
}

/*
resource "aws_sns_topic_subscription" "region_fanout" {
  provider  = aws.secondary_region
  topic_arn = aws_sns_topic.primary.arn
  protocol  = "sqs"
  endpoint  = aws_sns_topic.secondary.arn
}
*/

