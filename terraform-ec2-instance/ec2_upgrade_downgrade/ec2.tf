# Define the EC2 instance
resource "aws_instance" "web_server" {
  ami = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  # instance_type               = "t2.micro"
  instance_type               = "t2.medium"
  key_name                    = "my-key-pair"
  vpc_security_group_ids      = [aws_security_group.web_server_sg_tf.id]
  associate_public_ip_address = true
  user_data_replace_on_change = true
  user_data                   = <<-EOF
    #!/bin/bash
    
    # Update package repositories
    apt-get update -y
    
    # Install nginx
    apt-get install nginx -y
    
    # Start nginx service
    systemctl start nginx
    
    # Enable nginx to start on boot
    systemctl enable nginx
  EOF

  tags = {
    Name = "MyTerraformEC2"
  }
}

output "instance_ip" {
  value = aws_instance.web_server.public_ip
}
