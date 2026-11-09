# Create a route table and associate the route table with subnet
# Here in the route all the traffic is passed through internet gateway.
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "tf-RT"
  }
}
