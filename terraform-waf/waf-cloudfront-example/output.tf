output "wafv2_web_acl_arn" {
  value = aws_wafv2_web_acl.cloudfront-waf.arn
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.id
}
