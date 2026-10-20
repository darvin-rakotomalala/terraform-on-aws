# Output the Staging Name Servers
output "subdomain_nameservers" {
  value = data.aws_route53_zone.public_zone.name_servers
}
