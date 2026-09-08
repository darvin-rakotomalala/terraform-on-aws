# Define the EC2 instance
resource "aws_instance" "ec2_example" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  key_name                    = "my-key-pair"
  security_groups             = [aws_security_group.sg.name]
  associate_public_ip_address = true
  user_data                   = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                sudo systemctl enable httpd
                echo "<h1>Hello from Terraform Data Sources!</h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Address:</strong> $(hostname -I | cut -d" " -f1)</p>" > /var/www/html/index.html
                sudo systemctl restart apache2
                EOF
  user_data_replace_on_change = true

  tags = {
    Name = "MyTerraformEC2"
  }
}

data "aws_instance" "myawsinstance" {
  filter {
    name   = "tag:Name"
    values = ["MyTerraformEC2"]
  }

  depends_on = [
    aws_instance.ec2_example
  ]
}

output "fetched_info_from_aws" {
  value = data.aws_instance.myawsinstance.public_ip
}
