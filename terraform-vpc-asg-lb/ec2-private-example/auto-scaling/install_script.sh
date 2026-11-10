#!/bin/bash
# Update all packages 
sudo apt-get update
# Install Apache2
sudo apt-get install -y apache2
# Enable Apache2 service
sudo systemctl start apache2
sudo systemctl enable httpd

# Create HTML file
echo "<html>
    <body>
      <h1>Welcome to my website</h1>
      <h1>Deployed EC2 Using VPC, ASG and ALB</h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Address:</strong> $(hostname -I | cut -d" " -f1)</p>
    </body>
</html>" > /var/www/html/index.html

# Restart Apache2 to load new HTML file
sudo systemctl restart apache2
