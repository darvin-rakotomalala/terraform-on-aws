# =============================================================================
# Data Sources
# =============================================================================

# Get Availability Zones - Primary Region
data "aws_availability_zones" "primary" {
  provider = aws.primary
  state    = "available"
}

# Get Availability Zones - Secondary Region
data "aws_availability_zones" "secondary" {
  provider = aws.secondary
  state    = "available"
}

# Get latest Amazon Linux 2023 AMI - Primary Region
data "aws_ami" "amazon_linux_primary" {
  provider    = aws.primary
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get latest Amazon Linux 2023 AMI - Secondary Region
data "aws_ami" "amazon_linux_secondary" {
  provider    = aws.secondary
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Route 53 Hosted Zone
data "aws_route53_zone" "main" {
  provider = aws.primary
  name     = var.domain_name
}
