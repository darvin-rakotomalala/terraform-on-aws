/*
    NAT Gateway: The NAT Gateway will give the private resources access to the internet. 
    To create the NAT Gateway, we’ll need to also create an Elastic IP first.
*/

resource "aws_eip" "web_eip" {
  domain = "vpc"
  tags = {
    Name = "tf-VpcEIP"
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.web_eip.id
  subnet_id     = aws_subnet.public-subnet-1.id
  tags = {
    Name = "tf-demo-NATGW"
  }
  depends_on = [aws_eip.web_eip]
}
