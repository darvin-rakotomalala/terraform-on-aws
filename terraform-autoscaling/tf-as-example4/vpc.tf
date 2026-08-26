# VPC Creation
data "aws_availability_zones" "available" {}

resource "aws_vpc" "terraform_vpc" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tf_vpc"
  }
}

# Public Subnet Creation
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = "172.31.18.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-Subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = "172.31.20.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-Subnet-2"
  }
}

# create internet gateway
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "tf-igw"
  }
}

# create public route table
resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "tf-rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
}

resource "aws_route_table_association" "public_sub_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_route_table_association" "public_sub_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.tf_public_rt.id
}
