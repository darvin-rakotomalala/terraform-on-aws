# Define the EC2 instance
# Attach a security group to an EC2 resource
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
