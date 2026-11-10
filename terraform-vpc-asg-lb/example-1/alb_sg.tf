# Create Security Group For Load Balancer
resource "aws_security_group" "elb_sg" {
  name        = "tf-elb-sg"
  description = "Allow http inbound traffic for elb"
  vpc_id      = aws_vpc.CustomVPC.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tf-elb-sg"
  }
}
