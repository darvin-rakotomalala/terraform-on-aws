resource "aws_instance" "webserver-ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.public_subnet_id

  associate_public_ip_address = true          # Assigns a public IP to the instance
  key_name                    = "my-key-pair" # Optional: if you want to use an existing key pair

  user_data = file("./ec2-resources/apache-install.sh")

  tags = {
    Name = "tf-web-server-ec2"
  }
}
