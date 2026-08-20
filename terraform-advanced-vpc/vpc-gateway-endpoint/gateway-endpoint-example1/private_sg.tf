# Security Groups for Private Subnet
resource "aws_security_group" "private_sg" {
  name        = "demo-private-sg"
  description = "Allow SHH on port 22 from Bastion Host"
  vpc_id      = aws_vpc.network_vpc.id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public_subnet.cidr_block]
  }

  egress {
    description = "Allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-private-sg"
  }

}
