# Bastion Host in Public Subnet with EIP
resource "aws_instance" "BASTION_HOST" {
  ami                         = "ami-020cba7c55df1f615"
  instance_type               = "t2.micro"
  key_name                    = "my-key-pair"
  subnet_id                   = aws_subnet.public_subnet.id
  security_groups             = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  tags = {
    "Name" = "BASTAIN_HOST"
    "VPC"  = "AWS_NETWORKING"
  }
}

# EIP
resource "aws_eip" "BASTAIN_HOST_IP" {}

resource "aws_eip_association" "BASTION_HOST_EIP_MAPPING" {
  allocation_id = aws_eip.BASTAIN_HOST_IP.id
  instance_id   = aws_instance.BASTION_HOST.id
}
