#!/bin/bash
apt update
apt upgrade -y
apt install apache2 -y
echo "<h1>Hello world from highly available group of ec2 instances</h1><br></h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Address:</strong> $(hostname -I | cut -d" " -f1)</p>" > /var/www/html/index.html
systemctl start apache2
systemctl enable apache2