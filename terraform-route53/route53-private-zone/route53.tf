# 1. Create the Route 53 Private Hosted Zone
resource "aws_route53_zone" "private_zone" {
  name = var.domain_name

  # The vpc block defines the zone as private and associates it with a specific VPC
  vpc {
    vpc_id = aws_vpc.VPC_A.id
    # vpc_region is optional and defaults to the provider region if omitted
  }

  tags = {
    Environment = "r53-private"
  }
}

# Create a sample A record within the private hosted zone
resource "aws_route53_record" "internal_app" {
  zone_id    = aws_route53_zone.private_zone.zone_id
  name       = "nginx.${var.domain_name}" # e.g., app.internal.example.com
  type       = "A"
  ttl        = "300"
  records    = [aws_instance.VPC_A_Private_Subnet_A_Instance_A.private_ip]
  depends_on = [aws_instance.VPC_A_Private_Subnet_A_Instance_A]
}

# Private A DNS Record: Back-end server
resource "aws_route53_record" "r53-private-back-end" {
  zone_id    = aws_route53_zone.private_zone.zone_id
  name       = "backend.${var.domain_name}"
  type       = "A"
  ttl        = "300"
  records    = [aws_instance.VPC_A_Private_Subnet_A_Instance_A.private_ip]
  depends_on = [aws_instance.VPC_A_Private_Subnet_A_Instance_A]
}

# Private A DNS Record: DB Server
resource "aws_route53_record" "r53-private-rds" {
  zone_id    = aws_route53_zone.private_zone.zone_id
  name       = "db.${var.domain_name}"
  type       = "CNAME"
  ttl        = "300"
  records    = [aws_instance.VPC_A_Private_Subnet_A_Instance_A.private_ip]
  depends_on = [aws_instance.VPC_A_Private_Subnet_A_Instance_A]
}
