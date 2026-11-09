resource "aws_instance" "my_ec2_instance" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.tf_pub_sub.id
  security_groups             = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true          # Only for instances in public subnets
  key_name                    = "my-key-pair" # Replace with your existing key pair name

  tags = {
    Name = "tf-EC2-CustomVPC"
  }
}
