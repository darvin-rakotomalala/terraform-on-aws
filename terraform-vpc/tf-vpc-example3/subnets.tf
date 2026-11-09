# public subnet at 3 different availability zones.
resource "aws_subnet" "public-subnet-1" {
  cidr_block        = var.public_subnet_1_cidr
  vpc_id            = aws_vpc.productionvpc.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "tf-pub-sub-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block        = var.public_subnet_2_cidr
  vpc_id            = aws_vpc.productionvpc.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "tf-pub-sub-2"
  }
}

resource "aws_subnet" "public-subnet-3" {
  cidr_block        = var.public_subnet_3_cidr
  vpc_id            = aws_vpc.productionvpc.id
  availability_zone = "us-east-1c"
  tags = {
    Name = "tf-pub-sub-3"
  }
}

# private subnet at 3 different availability zones.
resource "aws_subnet" "private-subnet-1" {
  cidr_block        = var.private_subnet_1_cidr
  vpc_id            = aws_vpc.productionvpc.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "tf-priv-sub-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  cidr_block        = var.private_subnet_2_cidr
  vpc_id            = aws_vpc.productionvpc.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "tf-priv-sub-2"
  }
}

resource "aws_subnet" "private-subnet-3" {
  cidr_block        = var.private_subnet_3_cidr
  vpc_id            = aws_vpc.productionvpc.id
  availability_zone = "us-east-1c"
  tags = {
    Name = "tf-priv-sub-3"
  }
}
