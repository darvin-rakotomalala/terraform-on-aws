resource "aws_route_table" "PrivateRouteTable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.CustomNAT.id
  }

  tags = {
    Name = "tf-PrivateRT"
  }
}

resource "aws_route_table_association" "PrivateSubnetRTAssociation" {
  subnet_id      = aws_subnet.PrivateSubnet.id
  route_table_id = aws_route_table.PrivateRouteTable.id
}
