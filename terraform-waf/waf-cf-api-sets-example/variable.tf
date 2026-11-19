variable "wafv2_ip_sets" {
  description = "A map of WAFv2 IP set configurations"
  type = map(object({
    description        = string
    scope              = string
    ip_address_version = string
    addresses          = list(string)
  }))
  default = {
    "ipset_regional_ipv4" = {
      description        = "CloudFront IPv4 addresses for approved access"
      scope              = "CLOUDFRONT"
      ip_address_version = "IPV4"
      addresses          = ["70.52.109.138/32", "5.6.7.8/32"]
    }
  }
}
