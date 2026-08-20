# Security Groups for Public Subnet
resource "aws_security_group" "public_sg" {
  name        = "demo-public-sg"
  description = "Allow SHH on port 22 from anywhere"
  vpc_id      = aws_vpc.network_vpc.id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-public-sg"
  }

}
