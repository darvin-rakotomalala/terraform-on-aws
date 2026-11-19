/*
resource "aws_wafv2_ip_set" "blacklist_alb_ipv4" {
  name               = "${var.prefix}-alb-ipv4"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["127.0.0.1/32"]

  tags = {
    Name = "${var.prefix}-alb-ipv4"
  }
}
*/

resource "aws_wafv2_ip_set" "blacklist_cf_ipv4" {
  name               = "${var.prefix}-cf-ipv4"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = ["127.0.0.1/32"]

  tags = {
    Name = "${var.prefix}-cf-ipv4"
  }
}

/*
resource "aws_wafv2_ip_set" "blacklist_alb_ipv6" {
  name               = "${var.prefix}-alb-ipv6"
  scope              = "REGIONAL"
  ip_address_version = "IPV6"
  addresses          = ["2001:0db8:0000:0000:0000:0000:0000:0001/128"]

  tags = {
    Name = "${var.prefix}-alb-ipv6"
  }
}
*/

resource "aws_wafv2_ip_set" "blacklist_cf_ipv6" {
  name               = "${var.prefix}-cf-ipv6"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV6"
  addresses          = ["2001:0db8:0000:0000:0000:0000:0000:0001/128"]

  tags = {
    Name = "${var.prefix}-cf-ipv6"
  }
}
