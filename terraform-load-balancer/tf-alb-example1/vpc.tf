# VPC
resource "aws_vpc" "siva" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "tf-vpc"
  }
}

# public-subnet1
resource "aws_subnet" "public-subnet1" {
  vpc_id                  = aws_vpc.siva.id
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "tf-pub-sub1"
  }
}

# public-subnet2
resource "aws_subnet" "public-subnet2" {
  vpc_id                  = aws_vpc.siva.id
  cidr_block              = var.subnet2_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "tf-pub-sub2"
  }
}

# private-subnet1
resource "aws_subnet" "private-subnet1" {
  vpc_id            = aws_vpc.siva.id
  cidr_block        = var.subnet3_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "tf-priv-sub1"
  }
}

# Internet Gateway Creation
resource "aws_internet_gateway" "siva-gateway" {
  vpc_id = aws_vpc.siva.id
  tags = {
    Name = "tf-igw"
  }
}

# Creation of Route Table
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.siva.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.siva-gateway.id
  }
  tags = {
    Name = "tf-public-rt"
  }
}

# route 1
resource "aws_route_table_association" "route1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.route.id
}

# route 2
resource "aws_route_table_association" "route2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.route.id
}
