# Configuration section for vpc
resource "aws_vpc" "tf_vpc" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tf-vpc"
  }
}

# Configuration section for internet gateway
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf-igw"
  }
}

# Configuration section for elastic ip
# This EIP will be associated with NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "tf-nat-eip"
  }
}

# Configuration section for nat gateway
# Because NAT Gateway needs direct access to public/internet, 
# then it will be resided in a public subnet and will be associated with public IP.
resource "aws_nat_gateway" "tf_natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_sub.id

  tags = {
    Name = "tf-natgw"
  }
}

# Configuration section for public subnet
resource "aws_subnet" "public_sub" {
  cidr_block        = "18.0.0.0/24"
  vpc_id            = aws_vpc.tf_vpc.id
  availability_zone = var.availability_zone[0]

  tags = {
    Name = "tf-public-sub"
  }
}

# Configuration section for private subnet
resource "aws_subnet" "private_sub" {
  cidr_block        = "18.0.128.0/24"
  vpc_id            = aws_vpc.tf_vpc.id
  availability_zone = var.availability_zone[0]

  tags = {
    Name = "tf-private-sub"
  }
}

# Configuration section for route table public_rt
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf-public-RT"
  }
}

resource "aws_route" "default_public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = var.default_route
  gateway_id             = aws_internet_gateway.tf_igw.id
}

resource "aws_route_table_association" "public_sub_association" {
  subnet_id      = aws_subnet.public_sub.id
  route_table_id = aws_route_table.public_rt.id
}

# Configuration section for route table private_rt
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf-private-RT"
  }
}

# Route to internet from private_rt via nat gateway
resource "aws_route" "default_private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = var.default_route
  nat_gateway_id         = aws_nat_gateway.tf_natgw.id
}

resource "aws_route_table_association" "private_sub_association" {
  subnet_id      = aws_subnet.private_sub.id
  route_table_id = aws_route_table.private_rt.id
}
