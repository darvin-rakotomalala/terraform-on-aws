# Creation of EC2 instance 1
resource "aws_instance" "ecomm" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  key_name                    = "my-key-pair"
  vpc_security_group_ids      = [aws_security_group.web-sg.id]
  subnet_id                   = aws_subnet.public-subnet1.id
  associate_public_ip_address = true
  user_data                   = file("${path.module}/data.sh")
  user_data_replace_on_change = true
  tags = {
    name = "tf-EC2-ecomm"
  }
}

# Creation of EC2 instance 2
resource "aws_instance" "food" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  key_name                    = "my-key-pair"
  vpc_security_group_ids      = [aws_security_group.web-sg.id]
  subnet_id                   = aws_subnet.public-subnet1.id
  associate_public_ip_address = true
  user_data                   = file("${path.module}/data.sh")
  user_data_replace_on_change = true
  tags = {
    name = "tf-EC2-food"
  }
}
