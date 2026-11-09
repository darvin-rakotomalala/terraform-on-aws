# create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "18.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "tf-VPC"
  }
}

# create public and private subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "18.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.az_1
  tags = {
    Name = "tf-pub-sub-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "18.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.az_2
  tags = {
    Name = "tf-pub-sub-2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "18.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.az_3
  tags = {
    Name = "tf-pub-sub-3"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "18.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.az_1
  tags = {
    Name = "tf-priv-subt-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "18.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.az_2
  tags = {
    Name = "tf-priv-subt-2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "18.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.az_3
  tags = {
    Name = "tf-priv-subt-3"
  }
}

# create IGW and attach
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "tf-IGW"
  }
}

# create a public route table and associate the public subnets with an internet gateway added
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "tf-pulic-RT"
  }
}

resource "aws_route_table_association" "public_subnet_1a" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "public_subnet_2b" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "public_subnet_3c" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public_RT.id
}
