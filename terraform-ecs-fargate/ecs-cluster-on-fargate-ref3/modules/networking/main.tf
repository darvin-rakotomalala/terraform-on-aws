# -------  modules/networking/main.tf
resource "aws_vpc" "fargate" {
  cidr_block = var.vpc_cidr #our cidr is now a variable. 
  # instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "my-VPC"
  }
}

resource "aws_internet_gateway" "fargate_gw" {
  vpc_id = aws_vpc.fargate.id

  tags = {
    Name = "fargate-igw"
  }
}

data "aws_availability_zones" "available" {
}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = 2
}

resource "aws_subnet" "fargate_subnet" {
  count             = var.public_sn_count
  vpc_id            = aws_vpc.fargate.id
  cidr_block        = var.public_cidrs[count.index]
  availability_zone = random_shuffle.az_list.result[count.index]
  tags = {
    Name = "fargate ${count.index}"
  }
}

resource "aws_route_table" "fargate_rt" {
  vpc_id = aws_vpc.fargate.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fargate_gw.id
  }
}

resource "aws_route_table_association" "fargate" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.fargate_subnet[count.index].id
  route_table_id = aws_route_table.fargate_rt.id
}
