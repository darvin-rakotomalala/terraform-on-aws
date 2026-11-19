/*
    Below is an example of a Terraform script that creates an AWS WAFv2 Web ACL 
    with AWS Managed Core Rule Set, which is developed and maintained by AWS. 
    It provides essential protections such as preventing SQL Injection, 
    Cross-Site Scripting, HTTP flood attacks, scanning probes and more, 
    which are often considered industry best practices for securing web applications
*/
resource "aws_wafv2_web_acl" "example_CommonRuleSet" {
  name  = "myWebACL-CommonRuleSet"
  scope = "REGIONAL"

  default_action {
    allow {} # which means that if a request doesn't match any of the rules in the ACL, it will be allowed
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 0

    override_action {
      count {} # which means that the rule action is overridden with COUNT
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
    metric_name                = "webACLVisibilityConfig"
    sampled_requests_enabled   = true
  }

  tags = {
    Environment = "Dev"
    Name        = "webACL"
  }
}

output "example_CommonRuleSet" {
  description = "ARN of the REGIONAL CommonRuleSet WAF ACL"
  value       = aws_wafv2_web_acl.example_CommonRuleSet.arn
}
