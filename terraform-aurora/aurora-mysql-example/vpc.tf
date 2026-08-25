# VPC and Networking
resource "aws_vpc" "main" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "aurora-vpc"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "18.0.4.0/24"
  availability_zone = "us-east-1a" # Adjust AZ
  tags = {
    Name = "aurora-private-subnet-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "18.0.93.0/24"
  availability_zone = "us-east-1b" # Adjust AZ
  tags = {
    Name = "aurora-private-subnet-b"
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "default" {
  name       = "aurora-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  tags = {
    Name = "Aurora DB Subnet Group"
  }
}
