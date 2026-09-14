# Define the EC2 instance and EBS volumes
resource "aws_instance" "web_server" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  key_name                    = "my-key-pair"
  vpc_security_group_ids      = [aws_security_group.web_server_sg_tf.id]
  associate_public_ip_address = true
  user_data                   = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                sudo systemctl enable httpd
                echo "<h1>Hello from EBS Volume Snapshots!</h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Address:</strong> $(hostname -I | cut -d" " -f1)</p>" > /var/www/html/index.html
                sudo systemctl restart apache2
                EOF
  user_data_replace_on_change = true

  tags = {
    Name = "MyTerraformEC2"
  }
}

resource "aws_ebs_volume" "demo_volume" {
  availability_zone = aws_instance.web_server.availability_zone
  size              = 30
  tags = {
    Name = "MyTerraformEBSVolume"
  }
}

resource "aws_volume_attachment" "demo_volume_attachment" {
  device_name = "/dev/sdh"
  instance_id = aws_instance.web_server.id
  volume_id   = aws_ebs_volume.demo_volume.id
}

# Creating snapshots
resource "aws_ebs_snapshot" "demo_snapshot" {
  volume_id = aws_ebs_volume.demo_volume.id
  tags = {
    Name = "MyTerraformSnapshot"
  }
}
