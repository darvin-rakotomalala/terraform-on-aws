# VPC Creation
resource "aws_vpc" "Custom_VPC" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Custom-VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "Custom_IGW" {
  vpc_id = aws_vpc.Custom_VPC.id
  tags = {
    Name = "Custom-IGW"
  }
}

# Public Subnets
resource "aws_subnet" "public_us_east_1a" {
  vpc_id                  = aws_vpc.Custom_VPC.id
  cidr_block              = "18.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public-us-east-1a"
  }
}

resource "aws_subnet" "public_us_east_1b" {
  vpc_id                  = aws_vpc.Custom_VPC.id
  cidr_block              = "18.0.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "public-us-east-1b"
  }
}

resource "aws_subnet" "public_us_east_1c" {
  vpc_id                  = aws_vpc.Custom_VPC.id
  cidr_block              = "18.0.32.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "public-us-east-1c"
  }
}

# NAT Gateway and Elastic IP
resource "aws_eip" "NAT_ElasticIP" {
  tags = {
    Name = "Custom-NAT-ElasticIP"
  }
}

resource "aws_nat_gateway" "Custom_NAT" {
  allocation_id = aws_eip.NAT_ElasticIP.id
  subnet_id     = aws_subnet.public_us_east_1a.id
  tags = {
    Name = "Custom-NAT"
  }
}

# Private Subnets DEV
resource "aws_subnet" "private_dev_us_east_1a" {
  vpc_id            = aws_vpc.Custom_VPC.id
  cidr_block        = "18.0.64.0/20"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-dev-us-east-1a"
  }
}

resource "aws_subnet" "private_dev_us_east_1b" {
  vpc_id            = aws_vpc.Custom_VPC.id
  cidr_block        = "18.0.80.0/20"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-dev-us-east-1b"
  }
}

resource "aws_subnet" "private_dev_us_east_1c" {
  vpc_id            = aws_vpc.Custom_VPC.id
  cidr_block        = "18.0.96.0/20"
  availability_zone = "us-east-1c"
  tags = {
    Name = "private-dev-us-east-1c"
  }
}

# Private Subnets PROD
resource "aws_subnet" "private_prod_us_east_1a" {
  vpc_id            = aws_vpc.Custom_VPC.id
  cidr_block        = "18.0.128.0/20"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-prod-us-east-1a"
  }
}

resource "aws_subnet" "private_prod_us_east_1b" {
  vpc_id            = aws_vpc.Custom_VPC.id
  cidr_block        = "18.0.144.0/20"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-prod-us-east-1b"
  }
}

resource "aws_subnet" "private_prod_us_east_1c" {
  vpc_id            = aws_vpc.Custom_VPC.id
  cidr_block        = "18.0.160.0/20"
  availability_zone = "us-east-1c"
  tags = {
    Name = "private-prod-us-east-1c"
  }
}

# Route Tables and Subnet Associations
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.Custom_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Custom_IGW.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private_dev_route_table" {
  vpc_id = aws_vpc.Custom_VPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Custom_NAT.id
  }
  tags = {
    Name = "private-dev-route-table"
  }
}

resource "aws_route_table" "private_prod_route_table" {
  vpc_id = aws_vpc.Custom_VPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Custom_NAT.id
  }
  tags = {
    Name = "private-prod-route-table"
  }
}

resource "aws_route_table_association" "association_1" {
  subnet_id      = aws_subnet.public_us_east_1a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "association_2" {
  subnet_id      = aws_subnet.public_us_east_1b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "association_3" {
  subnet_id      = aws_subnet.public_us_east_1c.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "association_4" {
  subnet_id      = aws_subnet.private_dev_us_east_1a.id
  route_table_id = aws_route_table.private_dev_route_table.id
}

resource "aws_route_table_association" "association_5" {
  subnet_id      = aws_subnet.private_dev_us_east_1b.id
  route_table_id = aws_route_table.private_dev_route_table.id
}

resource "aws_route_table_association" "association_6" {
  subnet_id      = aws_subnet.private_dev_us_east_1c.id
  route_table_id = aws_route_table.private_dev_route_table.id
}

resource "aws_route_table_association" "association_7" {
  subnet_id      = aws_subnet.private_prod_us_east_1a.id
  route_table_id = aws_route_table.private_prod_route_table.id
}

resource "aws_route_table_association" "association_8" {
  subnet_id      = aws_subnet.private_prod_us_east_1b.id
  route_table_id = aws_route_table.private_prod_route_table.id
}

resource "aws_route_table_association" "association_9" {
  subnet_id      = aws_subnet.private_prod_us_east_1c.id
  route_table_id = aws_route_table.private_prod_route_table.id
}

# VPC Gateway Endpoints
resource "aws_vpc_endpoint" "s3_vpc_endpoint" {
  vpc_id            = aws_vpc.Custom_VPC.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.public_route_table.id,
    aws_route_table.private_dev_route_table.id,
    aws_route_table.private_prod_route_table.id
  ]

  tags = {
    Name = "S3-Gateway-Endpoint"
  }
}

resource "aws_vpc_endpoint" "dynamodb_vpc_endpoint" {
  vpc_id            = aws_vpc.Custom_VPC.id
  service_name      = "com.amazonaws.us-east-1.dynamodb"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.public_route_table.id,
    aws_route_table.private_dev_route_table.id,
    aws_route_table.private_prod_route_table.id
  ]

  tags = {
    Name = "DynamoDB-Gateway-Endpoint"
  }
}
