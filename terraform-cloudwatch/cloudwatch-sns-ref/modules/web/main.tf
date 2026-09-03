####################################################
# Create the Linux EC2 Web server
####################################################
resource "aws_instance" "web" {
  ami             = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type   = var.instance_type
  key_name        = var.instance_key
  security_groups = var.security_group_ec2
  monitoring      = true # Enabling will cost more charges!

  count     = length(var.public_subnets)
  subnet_id = element(var.public_subnets, count.index)

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

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-ec2-${count.index + 1}"
  })
}
