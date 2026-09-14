# Define the EC2 instance
resource "aws_instance" "web_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  availability_zone           = var.availability_zone
  key_name                    = "my-key-pair"
  vpc_security_group_ids      = [aws_security_group.web_server_sg_tf.id]
  associate_public_ip_address = true

  user_data                   = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                sudo systemctl enable httpd
                echo "<h1>Hello from attach EBS to EC2!</h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Address:</strong> $(hostname -I | cut -d" " -f1)</p>" > /var/www/html/index.html
                sudo systemctl restart apache2
                EOF
  user_data_replace_on_change = true

  tags = {
    Name = "MyTerraformEC2"
  }
}
