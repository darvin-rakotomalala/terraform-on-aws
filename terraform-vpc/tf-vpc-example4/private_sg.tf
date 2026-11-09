# Private Security Group
# The private security group allows all outbound traffic but no inbound traffic.
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "tf_private_sg"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []
  }
}
