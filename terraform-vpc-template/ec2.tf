# ---------- Instances --------

resource "aws_instance" "project_front_end_1a" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.public_http_sg.id]
  subnet_id                   = aws_subnet.public_project_subnet_1a.id
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user-data.sh")
  key_name                    = "my-key-pair"

  tags = {
    Name = "front_end_1a"
  }
}

resource "aws_instance" "project_front_end_1b" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.public_http_sg.id]
  subnet_id                   = aws_subnet.public_project_subnet_1b.id
  user_data                   = file("${path.module}/user-data.sh")
  key_name                    = "my-key-pair"
  associate_public_ip_address = true

  tags = {
    Name = "front_end_1b"
  }
}
