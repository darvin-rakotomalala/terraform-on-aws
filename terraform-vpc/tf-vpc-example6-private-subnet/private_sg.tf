# Configuration related to security groups
/*
  It will be created inside VPC tf-vpc. For Ingress/Inbound rule, 
  I am allowing port 22, 80, 443, and 5432 from source IP 18.0.0.0/24 
  (This CIDR block is slight broader from CIDR block that is used by public subnet which is /24), 
  the purpose is to summarize CIDR blocks that will be used by other public subnet 
  that later will be created. And for the Egress/Outbound rule, 
  this security group is allowing all traffic (all protocol, port, and destination).
*/
resource "aws_security_group" "demo_private_sg" {
  name        = "tf-private-sg"
  description = "Security Group for demo purposes"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description = "from public tf"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["18.0.0.0/24"]
  }

  ingress {
    description = "from public tf"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["18.0.0.0/24"]
  }

  ingress {
    description = "from public tf"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["18.0.0.0/24"]
  }

  ingress {
    description = "from public tf"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["18.0.0.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }

  tags = {
    Name = "tf-private-sg"
  }
}
