# create VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block           = "18.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "tf-VPC"
  }
}

# create public and private subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "18.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "tf-pub-sub"
  }
}

# create IGW and attach
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "tf-IGW"
  }
}

# create a public route table and associate the public subnets with an internet gateway added
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "tf-pulic-RT"
  }
}

resource "aws_route_table_association" "public_subnet_1a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_RT.id
}
