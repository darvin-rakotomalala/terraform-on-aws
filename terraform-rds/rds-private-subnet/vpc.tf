resource "aws_vpc" "main" {
  cidr_block = "18.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

# Create Subnets (at least two for Multi-AZ deployments, ideally private for RDS)
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "18.0.4.0/24"
  availability_zone = "us-east-1a" # Replace with your desired AZ
  tags = {
    Name = "my-private-subnet-a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "18.0.93.0/24"
  availability_zone = "us-east-1b" # Replace with your desired AZ
  tags = {
    Name = "my-private-subnet-b"
  }
}

# Create a DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  tags = {
    Name = "My DB Subnet Group"
  }
}

# Create a Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow inbound traffic to RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306 # Or your database's default port (e.g., 5432 for PostgreSQL)
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["18.0.0.0/16"] # Restrict access to your VPC's CIDR block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "RDS Security Group"
  }
}
