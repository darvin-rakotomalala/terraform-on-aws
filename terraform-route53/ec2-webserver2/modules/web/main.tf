####################################################
# Create the Ubuntu EC2 Web server
####################################################
resource "aws_instance" "web" {
  ami             = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type   = var.instance_type
  key_name        = var.instance_key
  security_groups = var.security_group_ec2

  count     = length(var.public_subnets)
  subnet_id = element(var.public_subnets, count.index)

  user_data_replace_on_change = true

  user_data = <<-EOF
        #!/bin/bash
        apt-get update -y
        apt-get install nginx -y
        systemctl start nginx
        systemctl enable nginx

        # Navigate to the web server's root directory
        cd /var/www/html

        echo "<font face = "Verdana" size = "5">"                               > /var/www/html/index.html
        echo "<center><h1>Ubuntu Server 24.04 LTS Deployed with Terraform</h1></center>"      >> /var/www/html/index.html
        echo "<center> <b>EC2 Instance Metadata</b> </center>"                  >> /var/www/html/index.html
        echo "<center> <b>Instance ID:</b> $(INSTANCE_ID) </center>"               >> /var/www/html/index.html
        echo "<center> <b>Availablity Zone:</b> $(AVAILABILITY_ZONE) </center>"             >> /var/www/html/index.html
        echo "<center> <b>Public Hostname:</b> $(hostname) </center>"          >> /var/www/html/index.html
        echo "<center> <b>Public IPv4 address:</b> $(hostname -I | cut -d" " -f1) </center>"                  >> /var/www/html/index.html
        echo "<center> <b>Private IPv4 addresses:</b> $(hostname -f) </center>"                  >> /var/www/html/index.html
        echo "</font>"
    EOF

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-ec2-${count.index + 1}"
  })
}
