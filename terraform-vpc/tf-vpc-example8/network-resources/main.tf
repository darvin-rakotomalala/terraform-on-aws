resource "aws_vpc" "default" {
  cidr_block           = "18.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "18.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-pub-subnet"
  }
}
