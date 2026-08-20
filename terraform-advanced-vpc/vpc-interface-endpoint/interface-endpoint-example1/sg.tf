# VPC Endpoint Security Group
resource "aws_security_group" "endpoint_sg" {
  name        = "endpoint-sg"
  description = "Allow traffic to VPC Interface Endpoint"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 443 # Example for HTTPS
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["18.0.0.0/16"] # Allow traffic from your VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "endpoint-sg"
  }
}
