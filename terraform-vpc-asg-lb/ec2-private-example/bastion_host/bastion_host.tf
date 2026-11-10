# Why Bastion Host? - This allows you to SSH into the bastion host and then jump to the private instances.
# Security group for bastion host
resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "SG for bastion host"
  vpc_id      = var.vpc_id
  tags = {
    Name = "bastion-sg"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTP connections"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming SSH connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Bastion host instance
resource "aws_instance" "bastion" {
  ami                    = "ami-020cba7c55df1f615"
  instance_type          = "t2.micro"
  key_name               = "my-key-pair"
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  subnet_id              = var.public_subnet_az1_id

  associate_public_ip_address = true
  monitoring                  = false
  tags = {
    Name = "Bastion Host"
  }
}
