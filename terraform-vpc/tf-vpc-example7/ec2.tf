# launch an ec2 instance
resource "aws_instance" "terraform-instance" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1.id
  key_name                    = "my-key-pair"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.terrafrom_sg.id]
  tags = {
    Name = "Tf-EC2-Instance"
  }
}

output "PublicIP" {
  value = aws_instance.terraform-instance.public_ip
}
