# This creates a WebACL for your CloudFront distributions
/*
  for us-east-1 (which is used for the CloudFront WebACL), because I’d like to see 
  CloudFront and its rules in the same region (it really doesn’t matter, just our preference)
*/
resource "aws_wafv2_web_acl" "cloudfront" {
  name  = "cloudfront-webACL"
  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 0

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "cloudfrontVisibilityConfig"
    sampled_requests_enabled   = true
  }

  tags = {
    Environment = "Dev"
    Name        = "cloudfrontWebACL"
  }
}

output "cloudfront_waf_acl_arn" {
  description = "ARN of the CloudFront WAF ACL"
  value       = aws_wafv2_web_acl.cloudfront.arn
}
