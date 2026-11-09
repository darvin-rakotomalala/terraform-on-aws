resource "aws_eip" "CustomEIP" {
  domain = "vpc"
  tags = {
    "Name" = "tf-CustomEIP"
  }
}

resource "aws_nat_gateway" "CustomNAT" {
  allocation_id = aws_eip.CustomEIP.id
  subnet_id     = aws_subnet.PublicSubnet.id
  tags = {
    Name = "tf-CustomNAT"
  }
}
