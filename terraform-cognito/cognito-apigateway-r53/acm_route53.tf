# Data source for the existing Route 53 hosted zone
data "aws_route53_zone" "example" {
  name = var.domain_name # Replace with your domain name
}

# Request and Validate an ACM Certificate
resource "aws_acm_certificate" "cert" {
  domain_name       = "api.${var.domain_name}" # The custom domain you want to use
  validation_method = "DNS"
  # For edge-optimized, ensure this resource is in the us-east-1 provider.
  tags = {
    Name = "api-cloudwithdarvin-com-cert"
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => dvo
  }

  allow_overwrite = true
  name            = each.value.resource_record_name
  records         = [each.value.resource_record_value]
  ttl             = 60
  type            = each.value.resource_record_type
  zone_id         = data.aws_route53_zone.example.zone_id
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# Create a Custom Domain Name in API Gateway
resource "aws_api_gateway_domain_name" "example" {
  domain_name              = "api.${var.domain_name}"
  regional_certificate_arn = aws_acm_certificate.cert.arn
  # Use 'EDGE' or 'REGIONAL'. 'EDGE' uses CloudFront internally.
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  security_policy = "TLS_1_2"
  # Add this line to ensure validation completes first
  depends_on = [aws_acm_certificate_validation.cert_validation]
}

# Map the API Stage to the Custom Domain
# Assuming you have an existing aws_api_gateway_rest_api resource named 'my_api'
# and a deployment/stage.
resource "aws_api_gateway_base_path_mapping" "example" {
  api_id      = aws_api_gateway_rest_api.my_api.id
  stage_name  = aws_api_gateway_stage.my_dev_stage.stage_name
  domain_name = aws_api_gateway_domain_name.example.domain_name
}

# Create the Route 53 Alias Record
resource "aws_route53_record" "api" {
  name    = "api.${var.domain_name}" # The full custom domain name
  type    = "A"
  zone_id = data.aws_route53_zone.example.zone_id

  alias {
    # Use the regional domain name and zone ID from the API Gateway domain resource
    name                   = aws_api_gateway_domain_name.example.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.example.regional_zone_id
    evaluate_target_health = false
  }
}
