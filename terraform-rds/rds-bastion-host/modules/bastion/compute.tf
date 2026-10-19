# EC2 instance for the bastion host
resource "aws_instance" "bastion" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.public_a.id
  availability_zone      = var.availability_zone_1
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install mysql-server
              sudo systemctl start mysql.service
              sudo systemctl enable mysql
            EOF
  tags                   = { Name = "bastion-host" }
}
