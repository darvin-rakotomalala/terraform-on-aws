resource "aws_wafv2_ip_set" "ip_list" {
  provider           = aws.east # note the provider
  name               = "approved-ip-list"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = ["70.52.109.138/32"] # reference your IP set variable
}

/*
resource "aws_wafv2_ip_set" "example" {
  for_each = var.wafv2_ip_sets

  # each.key refers to the map key (e.g., "ipset_regional_ipv4")
  name = each.key

  # each.value refers to the object associated with the key
  description        = each.value.description
  scope              = each.value.scope
  ip_address_version = each.value.ip_address_version
  addresses          = each.value.addresses
}
*/
