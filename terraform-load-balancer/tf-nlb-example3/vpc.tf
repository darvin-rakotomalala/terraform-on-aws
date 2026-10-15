
# Example VPC and Subnets (replace with your existing resources or define them here)
resource "aws_vpc" "example_vpc" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "18.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a" # Replace with your desired AZ
  tags = {
    Name = "tf-pub-sub-1a"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "18.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b" # Replace with your desired AZ
  tags = {
    Name = "tf-pub-sub-1b"
  }
}

# Internet Gateway Creation
resource "aws_internet_gateway" "my-gateway" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name = "tf-igw"
  }
}

# Creation of Route Table
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-gateway.id
  }
  tags = {
    Name = "tf-public-rt"
  }
}

# public route
resource "aws_route_table_association" "route_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route.id
}

# public route
resource "aws_route_table_association" "route_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route.id
}
