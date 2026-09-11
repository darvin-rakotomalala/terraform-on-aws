# Define the EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS
  instance_type = "t2.micro"
  key_name      = "my-key-pair"
  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id
  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

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
    Name = "MyEBS-EC2"
  }
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp3"
  encrypted         = true
  tags = {
    Name = "extraVolumeData-demo"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.web_server.id
}

resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = aws_ebs_volume.ebs-volume-1.id

  tags = {
    Name = "extraVolumeData_snap"
  }
}
