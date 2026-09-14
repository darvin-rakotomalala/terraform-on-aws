# Define the EC2 instance
resource "aws_instance" "web_server" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  key_name                    = "my-key-pair"
  vpc_security_group_ids      = [aws_security_group.web_server_sg_tf.id]
  associate_public_ip_address = true

  user_data = <<-EOF
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

# Configuring Root Volume
/*
resource "aws_instance" "example_instance_with_root_config" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
  tags = {
    Name = "EC2WithCustomRoot"
  }
}
*/

# Attaching EBS Volumes to EC2 Instances
resource "aws_volume_attachment" "example_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example_volume.id
  instance_id = aws_instance.web_server.id
}

# Defining EBS Volumes
resource "aws_ebs_volume" "example_volume" {
  availability_zone = "us-east-1a" # Replace with your desired AZ
  size              = 50           # Volume size in GiB
  type              = "gp3"        # Volume type
  encrypted         = true
  tags = {
    Name = "MyTerraformEBSVolume"
  }
}

output "instance_ip" {
  value = aws_instance.web_server.public_ip
}
