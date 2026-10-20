# Configure Route 53 to point to our newly created website
# Use a data source to look up an existing public hosted zone by its name
data "aws_route53_zone" "public_zone" {
  name = var.public_zone # The name must include the trailing dot
}

resource "aws_route53_record" "exampleDomain-a" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = var.domainName
  type    = "A"
  alias {
    name                   = aws_s3_bucket_website_configuration.blog.website_domain
    zone_id                = aws_s3_bucket.dns_bucket.hosted_zone_id
    evaluate_target_health = true
  }
}
