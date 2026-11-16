# create a new VPC
resource "aws_vpc" "project" {     # we named it project
  cidr_block       = "18.0.0.0/16" # this is your CIDR range for the VPC
  instance_tenancy = "default"

  # Enables the DNS resolution in the VPC (defaults to true, but good practice to be explicit)
  enable_dns_support = true

  # Enables instances in the VPC to be assigned a public DNS hostname
  enable_dns_hostnames = true

  # Tags are not required but we want to keep our stuff semi organized
  tags = {
    Name = "Project-vpc"
  }
}

# This IG will allows us to reach the internet, it will go into the public route table
resource "aws_internet_gateway" "project_gw" {
  vpc_id = aws_vpc.project.id #Here is is referencing the VPC we are creating 

  tags = {
    Name = "Project-igw"
  }
}

# ----------------Subnets-----------------
# We are going to create four subnets, 2 public in AZ's 1a and 1b, 
# And 2 private subnets in AZ's 1a and 1b
resource "aws_subnet" "public_project_subnet_1a" {
  vpc_id            = aws_vpc.project.id
  cidr_block        = "18.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "pub_subnet_1a"
  }
}

resource "aws_subnet" "public_project_subnet_1b" {
  vpc_id            = aws_vpc.project.id
  cidr_block        = "18.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "pub_subnet_1b"
  }
}

# Private subnets 
resource "aws_subnet" "private_project_subnet_1a" {
  vpc_id            = aws_vpc.project.id
  cidr_block        = "18.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "priv_subnet_1a"
  }
}

resource "aws_subnet" "private_project_subnet_1b" {
  vpc_id            = aws_vpc.project.id
  cidr_block        = "18.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "priv_subnet_1b"
  }
}

#--------Route Tables------------

# Public Route Table and RT Association
resource "aws_route_table" "public_project_route_table" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block = "0.0.0.0/0" # must be open for igw to point to
    gateway_id = aws_internet_gateway.project_gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# This associates our public routes to the the route table. 
resource "aws_route_table_association" "public_route_1" {
  subnet_id      = aws_subnet.public_project_subnet_1a.id
  route_table_id = aws_route_table.public_project_route_table.id
}

resource "aws_route_table_association" "public_route_2" {
  subnet_id      = aws_subnet.public_project_subnet_1b.id
  route_table_id = aws_route_table.public_project_route_table.id
}

# Private route table and RT Association
resource "aws_route_table" "private_project_route_table" {
  vpc_id = aws_vpc.project.id

  tags = {
    Name = "private-rt"
  }
}

# This associtates our routes to the private route table.
resource "aws_route_table_association" "private_route_1" {
  subnet_id      = aws_subnet.private_project_subnet_1a.id
  route_table_id = aws_route_table.private_project_route_table.id
}

resource "aws_route_table_association" "private_route_2" {
  subnet_id      = aws_subnet.private_project_subnet_1b.id
  route_table_id = aws_route_table.private_project_route_table.id
}


