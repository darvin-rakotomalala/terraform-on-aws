# EC2 demo-ubuntu-public
resource "aws_instance" "public_ec2_instance" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_sub.id
  security_groups             = [aws_security_group.demo_public_sg.id]
  associate_public_ip_address = true
  key_name                    = "my-key-pair"

  tags = {
    Name = "tf-public-EC2"
  }
}

# EC2 demo-ubuntu-private
resource "aws_instance" "private_ec2_instance" {
  ami             = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_sub.id
  security_groups = [aws_security_group.demo_private_sg.id]
  key_name        = "my-key-pair"

  tags = {
    Name = "tf-private-EC2"
  }
}
