# Create a VPC for your Aurora cluster (if you don't have one)
resource "aws_vpc" "main" {
  cidr_block = "18.0.0.0/16"
  tags = {
    Name = "aurora-vpc"
  }
}

# Create subnets for your Aurora instances
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "18.0.${count.index}.0/24"
  availability_zone = "us-east-1${element(["a", "b"], count.index)}" # Adjust AZs as needed
  tags = {
    Name = "aurora-private-subnet-${count.index}"
  }
}

# Create a DB subnet group
resource "aws_db_subnet_group" "main" {
  subnet_ids = aws_subnet.private[*].id
  tags = {
    Name = "aurora-db-subnet-group"
  }
}
