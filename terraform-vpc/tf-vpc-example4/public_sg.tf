# Public Security Group
# The public security group allows all inbound and outbound traffic.
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "tf_public_sg"
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
    cidr_blocks = ["0.0.0.0/0"]
  }
}
