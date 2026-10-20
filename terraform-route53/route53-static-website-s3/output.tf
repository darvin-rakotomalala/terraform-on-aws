output "website_endpoint" {
  # Referencing the new resource's website_endpoint attribute
  value = aws_s3_bucket_website_configuration.blog.website_endpoint
}

output "website_domain" {
  # Referencing the new resource's website_domain attribute
  value = aws_s3_bucket_website_configuration.blog.website_domain
}
