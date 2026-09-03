resource "aws_cloudwatch_log_group" "my_log_group" {
  name              = var.log_group_name
  retention_in_days = var.retention_days
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "demo-log-stream"
  log_group_name = aws_cloudwatch_log_group.my_log_group.name
}
