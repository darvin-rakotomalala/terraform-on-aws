# To view container logs in CloudWatch
# Set up Cloudwatch group and log stream for the application logs
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${var.app_name}-log"
  retention_in_days = 30

  tags = {
    Name = "/ecs/${var.app_name}"
  }
}

# Set up cloudwatch log stream for the ECS service
resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "${var.app_name}-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}
