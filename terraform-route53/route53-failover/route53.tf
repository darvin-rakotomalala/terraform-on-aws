data "aws_route53_zone" "my_zone" {
  name = var.name
}

resource "aws_route53_health_check" "dnshcheck" {
  fqdn              = "www.${data.aws_route53_zone.my_zone.name}"
  port              = 80
  type              = "HTTP"
  resource_path     = "/index.html"
  failure_threshold = "3"
  request_interval  = "10"
  ip_address        = aws_eip.webeip.public_ip

  tags = {
    Name = "primary-health-check"
  }
}

resource "aws_route53_record" "ec2" {
  zone_id         = data.aws_route53_zone.my_zone.zone_id
  name            = "www.${data.aws_route53_zone.my_zone.name}"
  type            = "A"
  ttl             = "60"
  health_check_id = aws_route53_health_check.dnshcheck.id
  records         = [aws_eip.webeip.public_ip]
  set_identifier  = "ec2"

  failover_routing_policy {
    type = "PRIMARY"
  }
}

resource "aws_route53_record" "s3" {
  zone_id        = data.aws_route53_zone.my_zone.zone_id
  name           = "www.${data.aws_route53_zone.my_zone.name}"
  type           = "A"
  set_identifier = "s3"

  alias {
    name                   = aws_s3_bucket_website_configuration.blog.website_domain
    zone_id                = aws_s3_bucket.dns_bucket.hosted_zone_id
    evaluate_target_health = false
  }

  failover_routing_policy {
    type = "SECONDARY"
  }
}
