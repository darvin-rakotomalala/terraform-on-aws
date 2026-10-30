data "aws_caller_identity" "current" {}

####################################################
# Create an SNS topic with a email subscription
####################################################
resource "aws_sns_topic" "s3-event-notification-topic" {
  name = "s3-event-notification-topic"
  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-sns-topic"
  })
}

# Example: Granting S3 permission to publish to an SNS topic
resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.s3-event-notification-topic.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.s3-event-notification-topic.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.my-bucket.arn
          }
        }
      }
    ]
  })
}

resource "aws_sns_topic_subscription" "topic-email-subscription" {
  count     = length(var.email_address)
  topic_arn = aws_sns_topic.s3-event-notification-topic.arn
  protocol  = "email"
  endpoint  = var.email_address[count.index]
}
