output "cdn_domain" {
  description = "The domain name of the CloudFront distribution"
  value       = module.site_prod.cdn_domain
}
