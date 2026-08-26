# create a new VPC for week21 project
resource "aws_vpc" "tf_VPC" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tf-VPC"
  }
}

# AWS availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# create internet gateway
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_VPC.id

  tags = {
    Name = "tf-IGW"
  }
}

# deploy two subnets to the VPC
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.tf_VPC.id
  cidr_block              = "172.16.18.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.tf_VPC.id
  cidr_block              = "172.16.20.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]
}

# create public route table
resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_VPC.id

  tags = {
    Name = "tf-RT"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
}

resource "aws_route_table_association" "public_sub_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_route_table_association" "public_sub_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.tf_public_rt.id
}
