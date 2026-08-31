####################################################
# Create the security group for EC2
####################################################
resource "aws_security_group" "security_group" {
  description = "Allow traffic for EC2"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ingress_ports
    iterator = sg_ingress

    content {
      description = sg_ingress.value["description"]
      from_port   = sg_ingress.value["port"]
      to_port     = sg_ingress.value["port"]
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-sg-ec2"
  })
}

####################################################
# Create the Linux EC2 instance with a website
####################################################
resource "aws_instance" "web" {
  ami                    = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type          = var.instance_type
  key_name               = var.instance_key
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.security_group.id]

  user_data_replace_on_change = true

  user_data = <<-EOF
        #!/bin/bash
        apt-get update -y
        apt-get install nginx -y
        systemctl start nginx
        systemctl enable nginx

        # Navigate to the web server's root directory
        cd /var/www/html

        echo "<font face = "Verdana" size = "5">"                                               > /var/www/html/index.html
        echo "<center><h1>Ubuntu Server 24.04 LTS deployed with Terraform</h1></center>"        >> /var/www/html/index.html
        echo "<center> <b>EC2 Instance Metadata</b> </center>"                                  >> /var/www/html/index.html
        echo "<center> <b>Instance ID:</b> $(INSTANCE_ID) </center>"                            >> /var/www/html/index.html
        echo "<center> <b>Availablity Zone:</b> $(AVAILABILITY_ZONE) </center>"                 >> /var/www/html/index.html
        echo "<center> <b>Public Hostname:</b> $(hostname) </center>"                           >> /var/www/html/index.html
        echo "<center> <b>Public IPv4 address:</b> $(hostname -I | cut -d" " -f1) </center>"    >> /var/www/html/index.html
        echo "<center> <b>Private IPv4 addresses:</b> $(hostname -f) </center>"                 >> /var/www/html/index.html
        echo "</font>"                                                                          >> /var/www/html/index.html
    EOF

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-ec2-${var.ec2_name}"
  })
}
