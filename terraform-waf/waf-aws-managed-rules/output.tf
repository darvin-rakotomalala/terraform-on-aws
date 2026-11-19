output "waf_arn" {
  value       = aws_wafv2_web_acl.this.arn
  description = "IP sets arn"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "S3 bucket arn"
}

/*output "waf_ipsets_alb_ipv4_arn" {
  value       = aws_wafv2_ip_set.blacklist_alb_ipv4.arn
  description = "IP sets arn"
}*/

# OUTPUT
output "waf_ipsets_cf_ipv4_arn" {
  value       = aws_wafv2_ip_set.blacklist_cf_ipv4.arn
  description = "IP sets arn"
}

/*output "waf_ipsets_alb_ipv6_arn" {
  value       = aws_wafv2_ip_set.blacklist_alb_ipv6.arn
  description = "IP sets arn"
}*/

output "waf_ipsets_cf_ipv6_arn" {
  value       = aws_wafv2_ip_set.blacklist_cf_ipv6.arn
  description = "IP sets arn"
}

output "wafv2_web_acl_arn" {
  value = aws_wafv2_web_acl.this.arn
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.id
}
