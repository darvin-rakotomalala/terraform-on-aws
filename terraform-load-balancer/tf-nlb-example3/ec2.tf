# Instance A
resource "aws_instance" "instance_a" {
  ami                         = var.ec2_ami
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.web-sg.id]
  key_name                    = "my-key-pair"
  associate_public_ip_address = true
  user_data                   = file("${path.module}/instance_a.sh")
  user_data_replace_on_change = true
  tags = {
    Name = "tf-Instance A"
  }
}

# Instance B
resource "aws_instance" "instance_b" {
  ami                         = var.ec2_ami
  instance_type               = "t2.micro"
  key_name                    = "my-key-pair"
  subnet_id                   = aws_subnet.public_subnet_2.id
  vpc_security_group_ids      = [aws_security_group.web-sg.id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/instance_b.sh")
  user_data_replace_on_change = true
  tags = {
    Name = "tf-Instance B"
  }
}
