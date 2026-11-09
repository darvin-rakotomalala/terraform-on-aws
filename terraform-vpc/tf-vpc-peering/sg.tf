## Security Group for VPC A
resource "aws_security_group" "allow_ssh_a" {
  name   = "tf-sg-a"
  vpc_id = aws_vpc.vpc_a.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg-a"
  }
}

## Security Group for VPC B
resource "aws_security_group" "allow_ssh_b" {
  name   = "tf-sg-b"
  vpc_id = aws_vpc.vpc_b.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg-b"
  }
}
