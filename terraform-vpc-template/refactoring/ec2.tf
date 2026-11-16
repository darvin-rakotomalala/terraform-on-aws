resource "aws_instance" "project_front_end" {
  count                       = var.instance_count
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.public_http_sg.id]
  subnet_id                   = aws_subnet.public_project_subnet[count.index].id
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user-data.sh")
  key_name                    = var.key_pair

  tags = {
    Name = "front_end-${count.index}"
  }
}
