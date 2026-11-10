# Create VPC
resource "aws_vpc" "main-vpc" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "main-vpc"
  }
}

# Create public subnet in AZ1
resource "aws_subnet" "public-subnet-az1" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = "18.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-subnet-az1"
  }
}

# Create public subnet in AZ2  
resource "aws_subnet" "public-subnet-az2" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = "18.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "public-subnet-az2"
  }
}

# Create private subnet in AZ1
resource "aws_subnet" "private-subnet-az1" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = "18.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-subnet-az1"
  }
}

# Create private subnet in AZ2
resource "aws_subnet" "private-subnet-az2" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = "18.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet-az2"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "main-igw"
  }
}

# Create public route table
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.main-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
  tags = {
    Name = "public-rtb"
  }
}

# Associate public route table with public subnets
resource "aws_route_table_association" "public-rtba-az1" {
  subnet_id      = aws_subnet.public-subnet-az1.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "public_rtba-az2" {
  subnet_id      = aws_subnet.public-subnet-az2.id
  route_table_id = aws_route_table.public-rtb.id
}

# Create private route table for AZ1
resource "aws_route_table" "private-rtb-az1" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "private-rtb-az1"
  }
}

# Create private route table for AZ 2
resource "aws_route_table" "private-rtb-az2" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "private-rtb-az2"
  }
}

# Associate private route table 1 with AZ1 private subnet
resource "aws_route_table_association" "private-rtba-az1" {
  subnet_id      = aws_subnet.private-subnet-az1.id
  route_table_id = aws_route_table.private-rtb-az1.id
}

# Associate private route table 2 with AZ2 private subnet
resource "aws_route_table_association" "private-rtba-az2" {
  subnet_id      = aws_subnet.private-subnet-az2.id
  route_table_id = aws_route_table.private-rtb-az2.id
}

# Endpoint to S3 bucket  
resource "aws_vpc_endpoint" "ep-s3" {
  vpc_id          = aws_vpc.main-vpc.id
  service_name    = "com.amazonaws.us-east-1.s3"
  route_table_ids = [aws_route_table.private-rtb-az1.id, aws_route_table.private-rtb-az2.id]
  tags = {
    Name = "ep-s3"
  }
}

# Create EIP for NAT Gateway AZ1
resource "aws_eip" "nat-eip-az1" {
  domain = "vpc"
  tags = {
    Name = "nat-eip-az1"
  }
}

# Create NAT Gateway for AZ1
resource "aws_nat_gateway" "nat-gw-az1" {
  allocation_id = aws_eip.nat-eip-az1.id
  subnet_id     = aws_subnet.public-subnet-az1.id
  depends_on    = [aws_internet_gateway.main-igw]
  tags = {
    Name = "nat-gw-az1"
  }
}

# Create route in private route table AZ1 to NAT Gateway
resource "aws_route" "nat-route-az1" {
  route_table_id         = aws_route_table.private-rtb-az1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw-az1.id
}

# Repeat for AZ2
resource "aws_eip" "nat-eip-az2" {
  domain = "vpc"
  tags = {
    Name = "nat-eip-az2"
  }
}

resource "aws_nat_gateway" "nat-gw-az2" {
  allocation_id = aws_eip.nat-eip-az2.id
  subnet_id     = aws_subnet.public-subnet-az2.id
  depends_on    = [aws_internet_gateway.main-igw]
  tags = {
    Name = "nat-gw-az2"
  }
}

resource "aws_route" "nat-route-az2" {
  route_table_id         = aws_route_table.private-rtb-az2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw-az2.id
}
