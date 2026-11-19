resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
  tags = {
    Name = "${var.prefix}-${var.name}"
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "api_server_waf_log" {
  log_destination_configs = [aws_s3_bucket.bucket.arn]
  resource_arn            = aws_wafv2_web_acl.this.arn
}
