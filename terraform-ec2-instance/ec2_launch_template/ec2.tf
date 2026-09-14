# Define the EC2 instance
resource "aws_instance" "web_server" {
  ami           = aws_launch_template.my_launch_template.image_id
  instance_type = aws_launch_template.my_launch_template.instance_type

  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest" # Use "$Latest" for the most recent version, or a specific version number
  }

  user_data                   = file("${path.module}/user-data.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "MyTerraformEC2"
  }
}

resource "aws_launch_template" "my_launch_template" {
  name_prefix   = "my-instance-template"
  image_id      = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type = "t2.micro"
  key_name      = "my-key-pair"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_server_sg_tf.id]
  }

  tags = {
    Name = "MyTFLaunchTemplate"
  }
}

output "instance_ip" {
  value = aws_instance.web_server.public_ip
}

output "launch_template_ip" {
  value = aws_launch_template.my_launch_template.id
}
