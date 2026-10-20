############################################
# Routing Policiess
############################################
/*
    Types of policies:
        - Routing policies
        - Simple routing policy
        - Weighted routing policy
        - Latency based routing policy
        - Failover routing policy
        - Geolocation routing policy
*/

# 1. Weighted Routing
resource "aws_route53_record" "www_weighted" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "primary.${var.domain_name}"
  type    = "A"

  weighted_routing_policy {
    weight = 90
  }

  set_identifier = "primary"
  records        = [var.primary_ip]
  ttl            = 60
}

resource "aws_route53_record" "www_weighted_secondary" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "secondary.${var.domain_name}"
  type    = "A"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "secondary"
  records        = [var.secondary_ip]
  ttl            = 60
}

/*
# 2. Latency-Based Routing
resource "aws_route53_record" "www_latency" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  latency_routing_policy {
    region = "us-west-2"
  }

  set_identifier = "us-west-2"
  records        = [var.us_west_2_ip]
  ttl           = 60
}

resource "aws_route53_record" "www_latency_eu" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  latency_routing_policy {
    region = "eu-west-1"
  }

  set_identifier = "eu-west-1"
  records        = [var.eu_west_1_ip]
  ttl           = 60
}
*/

# 3. Geolocation Routing
resource "aws_route53_record" "www_geo" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "geo.${var.domain_name}"
  type    = "A"

  geolocation_routing_policy {
    country = "US"
  }

  set_identifier = "us"
  records        = [var.us_ip]
  ttl            = 60
}

resource "aws_route53_record" "www_geo_default" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "geodefault.${var.domain_name}"
  type    = "A"

  geolocation_routing_policy {
    country = "*"
  }

  set_identifier = "default"
  records        = [var.default_ip]
  ttl            = 60
}


############################################
# Common Use Cases
# Multi-Region Application
############################################
resource "aws_route53_record" "api_failover" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "failover.${var.domain_name}"
  type    = "A"

  failover_routing_policy {
    type = "PRIMARY"
  }

  alias {
    name                   = var.primary_alb_dns
    zone_id                = data.aws_lb_hosted_zone_id.main.id # The ALB's Hosted Zone ID
    evaluate_target_health = true
  }

  set_identifier = "primary"
}

