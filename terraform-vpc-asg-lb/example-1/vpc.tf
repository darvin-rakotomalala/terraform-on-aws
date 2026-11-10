# Create Custom VPC
resource "aws_vpc" "CustomVPC" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "tf-CustomVPC"
  }
}

# Create IGW And associate with VPC
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.CustomVPC.id

  tags = {
    Name = "tf-IGW"
  }
}

# Create 2 Public Subnets
resource "aws_subnet" "PublicSubnet1" {
  vpc_id                  = aws_vpc.CustomVPC.id
  cidr_block              = "18.0.4.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-PublicSubnet1"
    Type = "Public"
  }
}

resource "aws_subnet" "PublicSubnet2" {
  vpc_id                  = aws_vpc.CustomVPC.id
  cidr_block              = "18.0.93.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-PublicSubnet2"
    Type = "Public"
  }
}

# Create Custom Public route table
resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.CustomVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "tf-PublicRT"
  }
}

# Create route table association with public route table
resource "aws_route_table_association" "PublicSubnetRTAssociation1" {
  subnet_id      = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.PublicRouteTable.id
}

resource "aws_route_table_association" "PublicSubnetRTAssociation2" {
  subnet_id      = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.PublicRouteTable.id
}
