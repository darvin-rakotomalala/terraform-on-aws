
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
  ami             = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type   = var.instance_type
  key_name        = var.instance_key
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.security_group.id]

  user_data = <<-EOF
        #!/bin/bash
        sudo apt-get update
        sudo apt-get install -y apache2
        sudo systemctl start apache2
        sudo systemctl enable httpd
        echo "<center><h1>Hello from EC2 Instance - Bastion Hosts with Terraform!</h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Address:</strong> $(hostname -I | cut -d" " -f1)</p></center>" > /var/www/html/index.html
        sudo systemctl restart apache2                                                        >> /var/www/html/index.html
    EOF

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-ec2-${var.ec2_name}"
  })
}
