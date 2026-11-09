# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tf-CustomVPC"
  }
}

# Set up Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "tf-IGW"
  }
}

# Public Subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "18.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-public-subnet1"
    Type = "Public"
  }
}

# Public Subnet and Route Table
resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "tf-publicRT"
  }
}

resource "aws_route_table_association" "PublicSubnetRTAssociation" {
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.PublicRouteTable.id
}
