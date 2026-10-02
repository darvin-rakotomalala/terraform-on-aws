resource "aws_vpc" "project" {
  cidr_block           = var.vpc_cidr # our cidr is now a variable. 
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Project-vpc"
  }
}

resource "aws_internet_gateway" "project_gw" {
  vpc_id = aws_vpc.project.id

  tags = {
    Name = "Project-igw"
  }
}

# We created our public subnets under one resource block by using count to create multiple. 
resource "aws_subnet" "public_project_subnet" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.project.id
  cidr_block        = var.public_cidrs[count.index]      # This interates over a list of CIDRS
  availability_zone = var.availability_zone[count.index] # Iterates over a like of AZ's
  tags = {
    Name = "pub-subnet${count.index}"
  }
}

# We created our private subnets under one resource block by using count to create multiple. 
resource "aws_subnet" "private_project_subnet" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.project.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    Name = "priv-subnet${count.index}"
  }
}

resource "aws_route_table" "public_project_route_table" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block = var.access_cidr
    gateway_id = aws_internet_gateway.project_gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# we now only have one public RT assc. that associates however many subnets we have in public sn to this RT
resource "aws_route_table_association" "public_route" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.public_project_subnet[count.index].id
  route_table_id = aws_route_table.public_project_route_table.id
}

# Private route table and RT Association
resource "aws_route_table" "private_project_route_table" {
  vpc_id = aws_vpc.project.id

  tags = {
    Name = "private-rt"
  }
}

# we now only have one private RT assc. that associates however many subnets we have in private sn to this RT
resource "aws_route_table_association" "private_route_" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.private_project_subnet[count.index].id
  route_table_id = aws_route_table.private_project_route_table.id
}
