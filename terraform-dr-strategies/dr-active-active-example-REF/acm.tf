# =============================================================================
# ACM Certificates
# =============================================================================

# ACM Certificate - Primary Region (us-east-1)
resource "aws_acm_certificate" "primary" {
  provider          = aws.primary
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name   = "${var.project_name}-primary-cert"
    Region = "us-east-1"
  }
}

# ACM Certificate - Secondary Region (us-west-2)
resource "aws_acm_certificate" "secondary" {
  provider          = aws.secondary
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name   = "${var.project_name}-secondary-cert"
    Region = "us-west-2"
  }
}

# DNS Validation Record (only need one since same domain)
resource "aws_route53_record" "cert_validation" {
  provider = aws.primary

  for_each = {
    for dvo in aws_acm_certificate.primary.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}

# Certificate Validation - Primary
resource "aws_acm_certificate_validation" "primary" {
  provider                = aws.primary
  certificate_arn         = aws_acm_certificate.primary.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# Certificate Validation - Secondary
resource "aws_acm_certificate_validation" "secondary" {
  provider                = aws.secondary
  certificate_arn         = aws_acm_certificate.secondary.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
