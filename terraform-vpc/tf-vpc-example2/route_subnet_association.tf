# Associate the route table with subnet
resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}
