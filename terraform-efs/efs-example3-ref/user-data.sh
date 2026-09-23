#!/bin/bash
sudo yum install httpd -y -q
sudo yum install php  -y -q
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install nfs-utils -y -q # Amazon ami has pre installed nfs utils
sudo service rpcbind restart
# Mounting Efs
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html
sudo chmod go+rw /var/www/html
sudo bash -c 'echo Welcome  > /var/www/html/index.html'

# yum update -y
# yum install -y httpd.x86_64
# systemctl start httpd.service
# systemctl enable httpd.service
# instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)
# instanceAZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
# pubHostName=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
# pubIPv4=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
# privHostName=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
# privIPv4=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

# echo "<font face = "Verdana" size = "5">"                               > /var/www/html/index.html
# echo "<center><h1>AWS Linux VM Deployed with Terraform</h1></center>"   >> /var/www/html/index.html
# echo "<center> <b>EC2 Instance Metadata</b> </center>"                  >> /var/www/html/index.html
# echo "<center> <b>Instance ID:</b> $instanceId </center>"                      >> /var/www/html/index.html
# echo "<center> <b>AWS Availablity Zone:</b> $instanceAZ </center>"             >> /var/www/html/index.html
# echo "<center> <b>Public Hostname:</b> $pubHostName </center>"                 >> /var/www/html/index.html
# echo "<center> <b>Public IPv4:</b> $pubIPv4 </center>"                         >> /var/www/html/index.html
# echo "<center> <b>Private Hostname:</b> $privHostName </center>"               >> /var/www/html/index.html
# echo "<center> <b>Private IPv4:</b> $privIPv4 </center>"                       >> /var/www/html/index.html
# echo "</font>"                                                          >> /var/www/html/index.html
