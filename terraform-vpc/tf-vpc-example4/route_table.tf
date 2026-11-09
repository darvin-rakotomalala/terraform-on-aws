# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "tf_public_RT"
  }
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}

# IP created above to provide internet access to the private subnet
# This route directs outbound traffic from the private subnet through the NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_nat_gateway.id
}
