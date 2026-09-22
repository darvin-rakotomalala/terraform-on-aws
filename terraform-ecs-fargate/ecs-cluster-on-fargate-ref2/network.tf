/*
    ECS tasks will run in private subnets for security. ALB will sit in public subnets.
*/

# Fetching AZs in the current region
data "aws_availability_zones" "available" {
}

# Creating vpc
resource "aws_vpc" "main" {
  cidr_block = "172.18.0.0/16"
  tags = {
    Name = "${var.app_name}-vpc"
  }
}

# Creating private subnet in each AZ
resource "aws_subnet" "private" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.main.id
  tags = {
    name = "${var.app_name}-private-subnet-${count.index}"
  }
}

# Creating public subnet in each AZ
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.az_count)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = {
    name = "${var.app_name}-public-subnet-${count.index}"
  }
}

# Creating Internet Gateway for the public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-igw"
  }
}

# Creating route table for the public subnet
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Creating elastic IP for for NAT Gateway
resource "aws_eip" "gw" {
  count      = var.az_count
  domain     = "vpc"
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "${var.app_name}-nat-eip-${count.index}"
  }
}

# Creating NAT Gateway in the public subnet
resource "aws_nat_gateway" "gw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.gw.*.id, count.index)

  tags = {
    Name = "${var.app_name}-nat-gw-${count.index}"
  }
}

# Creating a route table for private subnet to route traffic through the NAT Gateway
resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.gw.*.id, count.index)
  }
  tags = {
    Name = "${var.app_name}-private-rt-${count.index}"
  }
}

# Associate the route table to the private subnet
resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
