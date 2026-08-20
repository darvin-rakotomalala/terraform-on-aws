# Interface Endpoint Type RDS
resource "aws_vpc_endpoint" "ie_rds" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.rds" # Replace with your desired service
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_a.id, aws_subnet.private_b.id] # Subnets where Elastic Network Interfaces (ENIs) will be created
  security_group_ids  = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = true # Set to true for most services to use private DNS names
  tags = {
    Name = "rds-interface-endpoint"
  }
}
