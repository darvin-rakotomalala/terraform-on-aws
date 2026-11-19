resource "aws_wafv2_web_acl" "example_acl" {
  provider    = aws.east # Note the provider alias "east"       
  name        = "example-wafv2-web-ACL"
  description = "example wafv2 for cloudfront web ACL"
  scope       = "CLOUDFRONT"

  custom_response_body {
    key          = "restricted"
    content      = <<HTML
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>restricted</title>
            </head>
            <body>
                <h1>restricted</h1>
                <p>This content is restricted</p>
            </body>
            </html>
            HTML
    content_type = "TEXT_HTML"
  }

  default_action {
    block {
      custom_response {
        response_code            = 403
        custom_response_body_key = "restricted"
      }
    }
  }

  rule {
    name     = "AllowIPs"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.ip_list.arn # reference your IP set resource
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-waf-logs-example-rule-allow"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "aws-waf-logs-example"
    sampled_requests_enabled   = true
  }

  tags = {
    name = "my-WAF-example"
  }
}
