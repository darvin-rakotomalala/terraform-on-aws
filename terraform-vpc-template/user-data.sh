#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable httpd
echo "<center><h1>Hello from EC2 Instance - the basics VPC with Terraform!</h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Address:</strong> $(hostname -I | cut -d" " -f1)</p></center>" > /var/www/html/index.html
sudo systemctl restart apache2