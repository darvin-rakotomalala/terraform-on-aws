# create the VPC
resource "aws_vpc" "network_vpc" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "AWS_NETWORKING"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.network_vpc.id
  cidr_block              = "18.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    "Name" = "PublicSubnet_1"
    "VPC"  = "AWS_NETWORKING"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "network_vpc_igw" {
  tags = {
    "Name" = "AWS_NETWORKING"
  }
}

resource "aws_internet_gateway_attachment" "igw_vpc_attachement" {
  internet_gateway_id = aws_internet_gateway.network_vpc_igw.id
  vpc_id              = aws_vpc.network_vpc.id
}

# Route Table for Public Subnet with Association
resource "aws_route_table" "RT_PUBLIC" {
  vpc_id = aws_vpc.network_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.network_vpc_igw.id
  }
  tags = {
    "Name" = "RT_PUBLIC"
    "VPC"  = "AWS_NETWORKING"
  }
}

resource "aws_route_table_association" "subnet_route_table_association" {
  route_table_id = aws_route_table.RT_PUBLIC.id
  subnet_id      = aws_subnet.public_subnet.id
}

# Private subnet
resource "aws_subnet" "private_subnet" {
  cidr_block        = "18.0.1.0/24"
  vpc_id            = aws_vpc.network_vpc.id
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "PrivateSubnet_1"
    "VPC"  = "AWS_NETWORKING"
  }
}

# Private Route Table and Private Subnet Association.
resource "aws_route_table" "RT_PRIVATE" {
  vpc_id = aws_vpc.network_vpc.id
  tags = {
    "Name" = "RT_PRIVATE"
    "VPC"  = "AWS_NETWORKING"
  }
}

resource "aws_route_table_association" "privateRouteTable1_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.RT_PRIVATE.id
  depends_on     = [aws_subnet.private_subnet]
}
