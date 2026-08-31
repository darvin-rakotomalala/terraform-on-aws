# Hosted Zone
data "aws_route53_zone" "public_zone" {
  name = var.public_zone # The name must include the trailing dot
}

resource "aws_route53_record" "landing_page_A_record" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.static_site_distribution.domain_name    # CloudFront domain name
    zone_id                = aws_cloudfront_distribution.static_site_distribution.hosted_zone_id # CloudFront Hosted Zone ID
    evaluate_target_health = false
  }
  depends_on = [aws_cloudfront_distribution.static_site_distribution]
}

/*
resource "aws_route53_record" "landing_page_CNAME_record" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = var.domain_name
  type    = "CNAME"
  ttl     = "300"
  records = [aws_cloudfront_distribution.static_site_distribution.domain_name]
}
*/
