# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "TF-CustomVPC"
  }
}

# Set up Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "TF-IGW"
  }
}
