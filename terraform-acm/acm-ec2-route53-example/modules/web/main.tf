################################################################################
# Create the security group for EC2 Webservers
################################################################################
resource "aws_security_group" "ec2_security_group" {
  description = "Allow traffic for EC2 Webservers"
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
    Name = "${var.naming_prefix}-sg-webserver"
  })
}

################################################################################
# Create the Linux EC2 Web server
################################################################################
resource "aws_instance" "web" {
  ami           = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type = var.instance_type
  key_name      = var.instance_key

  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  count     = length(var.private_subnets)
  subnet_id = element(var.private_subnets, count.index)

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
        echo "<center><h1>Ubuntu Server 24.04 LTS Deployed with Terraform</h1></center>"        >> /var/www/html/index.html
        echo "<center> <b>EC2 Instance Metadata</b> </center>"                                  >> /var/www/html/index.html
        echo "<center> <b>Instance ID:</b> $(INSTANCE_ID) </center>"                            >> /var/www/html/index.html
        echo "<center> <b>Availablity Zone:</b> $(AVAILABILITY_ZONE) </center>"                 >> /var/www/html/index.html
        echo "<center> <b>Public Hostname:</b> $(hostname) </center>"                           >> /var/www/html/index.html
        echo "<center> <b>Public IPv4 address:</b> $(hostname -I | cut -d" " -f1) </center>"    >> /var/www/html/index.html
        echo "<center> <b>Private IPv4 addresses:</b> $(hostname -f) </center>"                 >> /var/www/html/index.html
        echo "</font>"
    EOF

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-ec2-${count.index + 1}"
  })
}
