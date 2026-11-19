#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "app-server" {
  count                  = length(var.subnet_cidr_public)
  instance_type          = var.instance_type
  ami                    = var.ami_name
  vpc_security_group_ids = [aws_security_group.ec2_instance.id]
  subnet_id              = element(module.vpc.public_subnets.*.id, count.index)

  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#associate_public_ip_address
  associate_public_ip_address = true
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  ebs_optimized = true
  monitoring    = true

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "app-server-${count.index + 1}"
  }

  user_data_replace_on_change = true
  user_data                   = <<-EOF
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
}
