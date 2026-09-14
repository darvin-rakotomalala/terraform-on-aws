# Define the EC2 instance
resource "aws_instance" "web_server" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  key_name                    = "my-key-pair"
  vpc_security_group_ids      = [aws_security_group.web_server_sg_tf.id]
  associate_public_ip_address = true

  tags = {
    Name = "MyTerraformEC2"
  }
}

# Creating elastic IP
resource "aws_eip" "example" {
  domain = "vpc"
  tags = {
    Name = "MyTerraformEIP"
  }
}

# Attaching Elatic IP to Instance 
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web_server.id
  allocation_id = aws_eip.example.id
}

output "instance_ip" {
  value = aws_instance.web_server.public_ip
}
