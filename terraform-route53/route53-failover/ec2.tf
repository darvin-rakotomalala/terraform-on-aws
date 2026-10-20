resource "aws_instance" "myweb" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.pub_dns.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  depends_on                  = [aws_internet_gateway.webig]

  user_data_replace_on_change = true
  user_data                   = file("${path.module}/user-data.sh")

  /*
  user_data = <<-EOF
            #!/bin/bash -xe
            sudo apt-get update
            sudo apt-get install -y apache2
            sudo apt-get install -y httpd wget git
            cd /tmp
            git clone https://github.com/ValAug/AWS_Route53_Terraform.git
            cp ./AWS_Route53_Terraform/mainweb/* /var/www/html
            chmod 2775 /var/www
            find /var/www -type d -exec chmod 2775 {} \;
            find /var/www -type f -exec chmod 0664 {} \;

            sudo systemctl start apache2
            sudo systemctl enable httpd
            sudo systemctl restart apache2
        EOF
  */
  tags = {
    Name = "myweb-ec2"
  }
}
