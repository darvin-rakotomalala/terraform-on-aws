# =============================================================================
# VPC - PRIMARY REGION (us-east-1)
# =============================================================================

resource "aws_vpc" "primary" {
  provider             = aws.primary
  cidr_block           = "18.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-primary-vpc"
  }
}

resource "aws_internet_gateway" "primary" {
  provider = aws.primary
  vpc_id   = aws_vpc.primary.id

  tags = {
    Name = "${var.project_name}-primary-igw"
  }
}

resource "aws_subnet" "primary_public_1" {
  provider                = aws.primary
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "18.1.1.0/24"
  availability_zone       = data.aws_availability_zones.primary.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-primary-public-1"
  }
}

resource "aws_subnet" "primary_public_2" {
  provider                = aws.primary
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "18.1.2.0/24"
  availability_zone       = data.aws_availability_zones.primary.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-primary-public-2"
  }
}

resource "aws_route_table" "primary_public" {
  provider = aws.primary
  vpc_id   = aws_vpc.primary.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary.id
  }

  tags = {
    Name = "${var.project_name}-primary-public-rt"
  }
}

resource "aws_route_table_association" "primary_public_1" {
  provider       = aws.primary
  subnet_id      = aws_subnet.primary_public_1.id
  route_table_id = aws_route_table.primary_public.id
}

resource "aws_route_table_association" "primary_public_2" {
  provider       = aws.primary
  subnet_id      = aws_subnet.primary_public_2.id
  route_table_id = aws_route_table.primary_public.id
}

# =============================================================================
# VPC - SECONDARY REGION (us-west-2)
# =============================================================================

resource "aws_vpc" "secondary" {
  provider             = aws.secondary
  cidr_block           = "18.2.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-secondary-vpc"
  }
}

resource "aws_internet_gateway" "secondary" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary.id

  tags = {
    Name = "${var.project_name}-secondary-igw"
  }
}

resource "aws_subnet" "secondary_public_1" {
  provider                = aws.secondary
  vpc_id                  = aws_vpc.secondary.id
  cidr_block              = "18.2.1.0/24"
  availability_zone       = data.aws_availability_zones.secondary.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-secondary-public-1"
  }
}

resource "aws_subnet" "secondary_public_2" {
  provider                = aws.secondary
  vpc_id                  = aws_vpc.secondary.id
  cidr_block              = "18.2.2.0/24"
  availability_zone       = data.aws_availability_zones.secondary.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-secondary-public-2"
  }
}

resource "aws_route_table" "secondary_public" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.secondary.id
  }

  tags = {
    Name = "${var.project_name}-secondary-public-rt"
  }
}

resource "aws_route_table_association" "secondary_public_1" {
  provider       = aws.secondary
  subnet_id      = aws_subnet.secondary_public_1.id
  route_table_id = aws_route_table.secondary_public.id
}

resource "aws_route_table_association" "secondary_public_2" {
  provider       = aws.secondary
  subnet_id      = aws_subnet.secondary_public_2.id
  route_table_id = aws_route_table.secondary_public.id
}
