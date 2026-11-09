# Launch an ec2 instance
resource "aws_instance" "my_ec2_instance" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true          # Assigns a public IP to the instance
  key_name                    = "my-key-pair" # Optional: if you want to use an existing key pair

  tags = {
    Name = "Tf-EC2-Instance"
  }
}

output "PublicIP" {
  value = aws_instance.my_ec2_instance.public_ip
}
