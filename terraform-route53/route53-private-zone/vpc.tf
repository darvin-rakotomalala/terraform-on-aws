resource "aws_vpc" "VPC_A" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "VPC_A"
  }
}

resource "aws_internet_gateway" "VPC_A_IGW" {
  vpc_id = aws_vpc.VPC_A.id

  tags = {
    Name = "VPC_A_IGW"
  }
}

resource "aws_subnet" "VPC_A_Public_Subnet_A" {
  vpc_id                  = aws_vpc.VPC_A.id
  cidr_block              = "18.0.20.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "VPC_A_Public_Subnet_A"
  }
}

resource "aws_route_table" "VPC_A_Public_RT_A" {
  vpc_id = aws_vpc.VPC_A.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.VPC_A_IGW.id
  }

  tags = {
    Name = "VPC_A_Public_RT_A"
  }
}

resource "aws_route_table_association" "VPC_A_Public_RT_A_Association_A" {
  subnet_id      = aws_subnet.VPC_A_Public_Subnet_A.id
  route_table_id = aws_route_table.VPC_A_Public_RT_A.id
}

resource "aws_eip" "EIP_for_NAT_GW" {
  domain = "vpc"
}

resource "aws_nat_gateway" "NAT_GW" {
  subnet_id         = aws_subnet.VPC_A_Public_Subnet_A.id
  connectivity_type = "public"
  allocation_id     = aws_eip.EIP_for_NAT_GW.id

  tags = {
    "Name" = "NAT_GW"
  }
}

resource "aws_subnet" "VPC_A_Private_Subnet_A" {
  vpc_id                  = aws_vpc.VPC_A.id
  cidr_block              = "18.0.10.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "VPC_A_Private_Subnet_A"
  }
}

resource "aws_route_table" "VPC_A_Private_RT_A" {
  vpc_id = aws_vpc.VPC_A.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT_GW.id
  }

  tags = {
    Name = "VPC_A_Private_RT_A"
  }
}

resource "aws_route_table_association" "VPC_A_Private_RT_A_Association" {
  subnet_id      = aws_subnet.VPC_A_Private_Subnet_A.id
  route_table_id = aws_route_table.VPC_A_Private_RT_A.id
}
