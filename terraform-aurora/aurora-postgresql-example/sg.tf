# Create a security group for the Aurora cluster
resource "aws_security_group" "aurora_sg" {
  vpc_id      = aws_vpc.main.id
  name        = "aurora-security-group"
  description = "Allow PostgreSQL traffic"

  ingress {
    from_port   = 5432 # PostgreSQL default port
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
