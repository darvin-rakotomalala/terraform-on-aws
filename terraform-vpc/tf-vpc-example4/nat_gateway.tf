# An Elastic IP (EIP) is required for the NAT Gateway.
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# The NAT Gateway is placed in the public subnet and uses the Elastic
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "tf_nat_gw"
  }
}
