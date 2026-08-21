resource "aws_vpc" "main" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# Create Subnets
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "18.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "pub-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "18.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "priv-subnet"
  }
}

# Create an Internet Gateway.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-igw"
  }
}

# Create Route Tables and Associations.
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# (Optional) Create a NAT Gateway.
resource "aws_eip" "nat_eip" {
  domain = "vpc" # Specifies that the EIP is for use in a VPC
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id # NAT Gateway must be in a public subnet
  tags = {
    Name = "my-nat-gateway"
  }
}

# (Optional) Private Route Table for NAT Gateway:
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}
