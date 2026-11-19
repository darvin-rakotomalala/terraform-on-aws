# This creates a WebACL for your regional resources, such as API Gateway
/*
    for ca-central-1 (which is used for the API Gateway WebACL where our services are located).
    The alias in the second provider block allows us to specify which provider to use 
    in our regional WebACL.
*/
provider "aws" {
  alias  = "ca-central-1"
  region = "ca-central-1"
}

resource "aws_wafv2_web_acl" "regional" {
  provider = aws.ca-central-1

  name  = "regional-webACL"
  scope = "REGIONAL"

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
    metric_name                = "regionalVisibilityConfig"
    sampled_requests_enabled   = true
  }

  tags = {
    Environment = "Dev"
    Name        = "regionalWebACL"
  }
}

output "regional_waf_acl_arn" {
  description = "ARN of the regional WAF ACL"
  value       = aws_wafv2_web_acl.regional.arn
}
