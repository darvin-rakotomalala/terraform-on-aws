####################################################
# Get latest Amazon Linux 2 AMI
####################################################
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

####################################################
# Create the Linux EC2 Web server
####################################################
resource "aws_instance" "webserver" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.subnet[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = "my-key-pair"

  user_data                   = file("${path.module}/user-data.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "my-Webserver"
  }
}
