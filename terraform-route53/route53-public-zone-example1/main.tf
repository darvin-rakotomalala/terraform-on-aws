# Use a data source to look up an existing public hosted zone by its name
data "aws_route53_zone" "public_zone" {
  name = "cloudwithdarvin.com" # The name must include the trailing dot
}

# Example of creating a record in the existing zone
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.public_zone.zone_id # Reference the ID from the data source
  name    = "www.${data.aws_route53_zone.public_zone.name}"
  type    = "A"
  ttl     = "300"
  records = ["3.83.206.162"]
}

# Create the NS record in the parent zone to delegate to the subdomain zone
resource "aws_route53_record" "subdomain_ns_delegation" {
  # This record resides in the parent zone
  zone_id = data.aws_route53_zone.public_zone.zone_id

  # The name of the record is the subdomain
  name = "dev.cloudwithdarvin.com"
  type = "NS"
  ttl  = "172800" # A common TTL for delegation records

  # The records are the name servers automatically generated for the subdomain zone
  records = data.aws_route53_zone.public_zone.name_servers
}
