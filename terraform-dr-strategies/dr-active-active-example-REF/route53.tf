# =============================================================================
# ROUTE 53 FAILOVER
# =============================================================================

# Health Check for Primary ALB
resource "aws_route53_health_check" "primary" {
  provider          = aws.primary
  fqdn              = aws_lb.primary.dns_name
  port              = 443
  type              = "HTTPS"
  resource_path     = "/health"
  failure_threshold = "2"
  request_interval  = "10"

  tags = {
    Name = "${var.project_name}-primary-health-check"
  }
}

# Failover Record - Primary
resource "aws_route53_record" "failover_primary" {
  provider = aws.primary
  zone_id  = data.aws_route53_zone.main.zone_id
  name     = var.domain_name
  type     = "A"

  failover_routing_policy {
    type = "PRIMARY"
  }

  set_identifier  = "primary"
  health_check_id = aws_route53_health_check.primary.id

  alias {
    name                   = aws_lb.primary.dns_name
    zone_id                = aws_lb.primary.zone_id
    evaluate_target_health = true
  }
}

# Failover Record - Secondary
resource "aws_route53_record" "failover_secondary" {
  provider = aws.primary
  zone_id  = data.aws_route53_zone.main.zone_id
  name     = var.domain_name
  type     = "A"

  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier = "secondary"

  alias {
    name                   = aws_lb.secondary.dns_name
    zone_id                = aws_lb.secondary.zone_id
    evaluate_target_health = true
  }
}
