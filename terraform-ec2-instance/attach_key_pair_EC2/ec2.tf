# Define the EC2 instance
resource "aws_instance" "my_ubuntu_server" {
  ami             = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.sg.name]

  tags = {
    Name = "MyTerraformEC2"
  }
}
