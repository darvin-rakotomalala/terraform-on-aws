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

# Configuration section for subnet
resource "aws_subnet" "tf_pub_sub" {
  cidr_block        = "18.0.0.0/24"
  vpc_id            = aws_vpc.tf_vpc.id
  availability_zone = var.az_1a

  tags = {
    Name = "tf-pub-sub"
  }
}

# Configuration section for route table
resource "aws_route_table" "tf_public_sub" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf-public-RT"
  }
}

resource "aws_route" "default_public_route" {
  route_table_id         = aws_route_table.tf_public_sub.id
  destination_cidr_block = var.default_route
  gateway_id             = aws_internet_gateway.tf_igw.id
}

resource "aws_route_table_association" "public_apse1_0" {
  subnet_id      = aws_subnet.tf_pub_sub.id
  route_table_id = aws_route_table.tf_public_sub.id
}
