# Create a VPC Gateway Endpoint for accessing the AWS Services privately.
resource "aws_vpc_endpoint" "gateway_endpoint" {
  vpc_id            = aws_vpc.network_vpc.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.RT_PRIVATE.id]
  tags = {
    "Name" = "GATEAGY_INTERFAC"
  }
}
