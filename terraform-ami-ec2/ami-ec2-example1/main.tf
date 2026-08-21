####################################################
# Create the Linux EC2 Web server
####################################################
resource "aws_instance" "ec2instance" {
  ami                    = "ami-0c101f26f147fa7fd"
  key_name               = "my-key-pair"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id # Reference the subnet ID
  vpc_security_group_ids = [aws_security_group.ec2sg.id]

  user_data = <<-EOF
      #!/bin/bash
      yum update -y
      yum install -y amazon-efs-utils
      yum install -y httpd.x86_64
      systemctl start httpd.service
      systemctl enable httpd.service
      instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)
      instanceAZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
      pubHostName=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
      pubIPv4=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
      privHostName=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
      privIPv4=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

      echo "<font face = "Verdana" size = "5">"                               > /var/www/html/index.html
      echo "<center><h1>AWS Linux VM Deployed with Terraform</h1></center>"   >> /var/www/html/index.html
      echo "<center> <b>EC2 Instance Metadata</b> </center>"                  >> /var/www/html/index.html
      echo "<center> <b>Instance ID:</b> $instanceId </center>"                      >> /var/www/html/index.html
      echo "<center> <b>AWS Availablity Zone:</b> $instanceAZ </center>"             >> /var/www/html/index.html
      echo "<center> <b>Public Hostname:</b> $pubHostName </center>"                 >> /var/www/html/index.html
      echo "<center> <b>Public IPv4:</b> $pubIPv4 </center>"                         >> /var/www/html/index.html
      echo "<center> <b>Private Hostname:</b> $privHostName </center>"               >> /var/www/html/index.html
      echo "<center> <b>Private IPv4:</b> $privIPv4 </center>"                       >> /var/www/html/index.html
      echo "</font>"                                                          >> /var/www/html/index.html
EOF

  tags = {
    Name = "MyEC2Server"
  }
}

resource "aws_ami_from_instance" "ec2ami" {
  name               = "MyEC2Image"
  source_instance_id = aws_instance.ec2instance.id
  depends_on         = [aws_instance.ec2instance]
  tags = {
    Name = "MyEC2Image-ami"
  }
}
