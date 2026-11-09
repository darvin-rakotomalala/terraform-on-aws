resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "tf-publicRT"
  }
}

resource "aws_route_table_association" "PublicSubnetRouteTableAssociation1" {
  subnet_id      = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.PublicRouteTable.id
}

resource "aws_route_table_association" "PublicSubnetRouteTableAssociation2" {
  subnet_id      = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.PublicRouteTable.id
}
