/*
  This creates a regional WAFv2 ACL with a rate-based rule that blocks requests 
  once they exceed a limit of 10,000 requests from the same IP address.
*/
resource "aws_wafv2_web_acl" "rateLimitRule_example" {
  name        = "regional-rateLimitRule"
  description = "Example of a managed rule"
  scope       = "REGIONAL"

  default_action {
    block {}
  }

  rule {
    name     = "rateLimitRule"
    priority = 0

    action {
      count {}
    }

    statement {
      rate_based_statement {
        limit              = 10000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "friendly-metric-name"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = true
  }
}

output "rateLimitRule_example" {
  description = "ARN of the regional-rateLimitRule WAF ACL"
  value       = aws_wafv2_web_acl.rateLimitRule_example.arn
}
