output "all_addresses" {
  # Outputting the entire list
  value = aws_wafv2_ip_set.ip_list.addresses
}

output "wafv2_web_acl_arn" {
  value = aws_wafv2_web_acl.example_acl.arn
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.id
}


/*
# Optional: Output the ARNs of the created IP sets
output "wafv2_ip_set_arns" {
  value = { for k, v in aws_wafv2_ip_set.example : k => v.arn }
}
*/