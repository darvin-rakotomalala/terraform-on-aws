# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "tf-vpc"
  }
}

# public-subnet-a
resource "aws_subnet" "public-subnet-a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_a_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "tf-pub-sub-a"
  }
}

# public-subnet-b
resource "aws_subnet" "public-subnet-b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_b_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "tf-pub-sub-b"
  }
}

# public-subnet-c
resource "aws_subnet" "public-subnet-c" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_c_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "tf-pub-sub-c"
  }
}

# private-subnet-d
resource "aws_subnet" "private-subnet-d" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_d_cidr
  availability_zone = "us-east-1d"
  tags = {
    Name = "tf-priv-sub-d"
  }
}

# Internet Gateway Creation
resource "aws_internet_gateway" "my-gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "tf-igw"
  }
}

# Creation of Route Table
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-gateway.id
  }
  tags = {
    Name = "tf-public-rt"
  }
}

# public route 1
resource "aws_route_table_association" "route_a" {
  subnet_id      = aws_subnet.public-subnet-a.id
  route_table_id = aws_route_table.route.id
}

# public route 2
resource "aws_route_table_association" "route_b" {
  subnet_id      = aws_subnet.public-subnet-b.id
  route_table_id = aws_route_table.route.id
}

# public route 3
resource "aws_route_table_association" "route_c" {
  subnet_id      = aws_subnet.public-subnet-c.id
  route_table_id = aws_route_table.route.id
}
