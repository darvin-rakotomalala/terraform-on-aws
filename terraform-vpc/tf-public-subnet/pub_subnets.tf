resource "aws_subnet" "PublicSubnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "18.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-public-subnet1"
    Type = "Public"
  }
}

resource "aws_subnet" "PublicSubnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "18.0.64.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-public-subnet2"
    Type = "Public"
  }
}
