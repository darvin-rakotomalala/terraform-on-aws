####################################################
# Get latest Amazon Linux 2 AMI
####################################################
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

####################################################
# Create the Linux EC2 Web server
####################################################
resource "aws_instance" "webserver" {
  ami               = data.aws_ami.amazon-linux-2.id
  instance_type     = "t3.micro"
  availability_zone = "us-east-1"
  security_groups   = [aws_security_group.morning-ssh-http.name]
  key_name          = "my-key-pair"

  user_data = <<-EOF
        #!/bin/bash
        yum update -y
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
    Name = "my-Webserver"
  }
}
