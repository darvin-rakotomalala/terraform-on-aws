## VPC A
resource "aws_vpc" "vpc_a" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "tf-vpc-a"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.vpc_a.id
  cidr_block = "18.0.4.0/24"
}

resource "aws_internet_gateway" "igw_a" {
  vpc_id = aws_vpc.vpc_a.id
}

resource "aws_route_table" "rt_a" {
  vpc_id = aws_vpc.vpc_a.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_a.id
  }

  route {
    cidr_block                = aws_vpc.vpc_b.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.example.id
  }
}

resource "aws_route_table_association" "rta_subnet_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.rt_a.id
}

## VPC B
resource "aws_vpc" "vpc_b" {
  cidr_block           = "25.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "tf-vpc-b"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.vpc_b.id
  cidr_block = "25.0.4.0/24"
}

resource "aws_internet_gateway" "igw_b" {
  vpc_id = aws_vpc.vpc_b.id
}

resource "aws_route_table" "rt_b" {
  vpc_id = aws_vpc.vpc_b.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_b.id
  }

  route {
    cidr_block                = aws_vpc.vpc_a.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.example.id
  }
}

resource "aws_route_table_association" "rta_subnet_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.rt_b.id
}

## VPC Peering Connection
resource "aws_vpc_peering_connection" "example" {
  vpc_id      = aws_vpc.vpc_a.id
  peer_vpc_id = aws_vpc.vpc_b.id
  auto_accept = true
  tags = {
    Name = "tf-vpc-peering"
  }
}
