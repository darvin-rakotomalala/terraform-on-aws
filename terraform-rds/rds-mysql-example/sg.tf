resource "aws_security_group" "allow_mysql_traffic" {
  name        = "allow_mysql"
  description = "Allow MySQL traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow mysql"
  }
}
