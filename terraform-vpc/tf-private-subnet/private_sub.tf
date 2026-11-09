resource "aws_subnet" "PrivateSubnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "18.0.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-PrivateSubnet"
  }
}
