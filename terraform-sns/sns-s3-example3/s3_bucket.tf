####################################################
# Create an S3 Bucket
####################################################
resource "aws_s3_bucket" "my-bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-s3-bucket"
  })
}

####################################################
# Creating Bucket Event Notification
####################################################
resource "aws_s3_bucket_notification" "bucket-notification" {
  bucket = aws_s3_bucket.my-bucket.id
  # This depends_on ensures the policy is applied first
  depends_on = [aws_sns_topic_policy.default]
  topic {
    topic_arn = aws_sns_topic.s3-event-notification-topic.arn
    events    = ["s3:ObjectCreated:*"] # You can specify the events you are interested in
  }
}
