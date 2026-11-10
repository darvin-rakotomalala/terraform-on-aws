# Create Security Group For EC2
resource "aws_security_group" "ec2_sg" {
  name        = "tf-ec2-sg"
  description = "Allow http inbound traffic for elb"
  vpc_id      = aws_vpc.CustomVPC.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.elb_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tf-ec2-sg"
  }
}
