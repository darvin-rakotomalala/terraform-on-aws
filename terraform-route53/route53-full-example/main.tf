# Hosted Zone
data "aws_route53_zone" "public_zone" {
  name = var.public_zone # The name must include the trailing dot
}

############################################
# A Record
############################################
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [var.ip_address]
}

############################################
# CNAME Record ALB DNS name
############################################
resource "aws_route53_record" "subdomain" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "blog.${var.domain_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${var.cname_target}"] # ALB DNS name
}

/*
# Take, for example, defining common G Suite aliases for mail, calendar, and documents.
resource "aws_route53_record" "example_mail" {
  zone_id = "${aws_route53_zone.example.zone_id}"
  name    = "mail"
  type    = "CNAME"
  records = ["ghs.google.com"]
  ttl     = "${var.ttl}"
}

resource "aws_route53_record" "example_cal" {
  zone_id = "${aws_route53_zone.example.zone_id}"
  name    = "cal"
  type    = "CNAME"
  records = ["ghs.google.com"]
  ttl     = "${var.ttl}"
}

resource "aws_route53_record" "example_docs" {
  zone_id = "${aws_route53_zone.example.zone_id}"
  name    = "docs"
  type    = "CNAME"
  records = ["ghs.google.com"]
  ttl     = "${var.ttl}"
}

variable "example_gsuite" {  
  default = ["mail", "cal", "docs"]
}

resource "aws_route53_record" "example_gsuite" {  
  count   = "${length(var.example_gsuite)}"  
  zone_id = "${aws_route53_zone.example.zone_id}"  
  name    = "${element(var.example_gsuite, count.index)}"  
  type    = "CNAME"  
  records = ["ghs.google.com"]  
  ttl     = "${var.ttl}"
}

*/

############################################
# Alias Records
############################################
# Alias Records for AWS Services
# Alias record for CloudFront distribution
/*
resource "aws_route53_record" "cloudfront" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "front.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name # CloudFront domain name
    zone_id                = var.cloudfront_hosted_zone_id # CloudFront Hosted Zone ID
    evaluate_target_health = false
  }
}
*/

# Data Source: aws_lb_hosted_zone_id
data "aws_lb_hosted_zone_id" "main" {
  load_balancer_type = "application"
}

# Alias record for ALB
resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "api.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name                   # The ALB's DNS name
    zone_id                = data.aws_lb_hosted_zone_id.main.id # The ALB's Hosted Zone ID
    evaluate_target_health = true
  }
}

############################################
# Health Checks
############################################
resource "aws_route53_health_check" "web" {
  fqdn              = "www.${var.domain_name}"
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "3"
  request_interval  = "30"

  tags = {
    Name = "web-health-check"
  }
}

# Record with health check
resource "aws_route53_record" "www_with_health_check" {
  zone_id         = data.aws_route53_zone.public_zone.zone_id
  name            = "check.${var.domain_name}"
  type            = "A"
  health_check_id = aws_route53_health_check.web.id

  failover_routing_policy {
    type = "PRIMARY"
  }

  set_identifier = "primary"
  records        = [var.primary_ip]
  ttl            = 60
}

############################################
# Monitoring Configuration
############################################
resource "aws_cloudwatch_metric_alarm" "dns_queries" {
  alarm_name          = "${var.domain_name}-dns-queries"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "DNSQueries"
  namespace           = "AWS/Route53"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1000"
  alarm_description   = "DNS queries exceeded threshold"
  # alarm_actions      = [var.sns_topic_arn]

  dimensions = {
    HostedZoneId = data.aws_route53_zone.public_zone.zone_id
  }
}

