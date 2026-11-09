# Instance A
resource "aws_instance" "instance_a" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_a.id
  key_name                    = var.key_pair
  associate_public_ip_address = true
  security_groups             = [aws_security_group.allow_ssh_a.id]
  lifecycle {
    ignore_changes = [security_groups]
  }
  tags = {
    Name = "tf-instance-a"
  }
}

# Instance B
resource "aws_instance" "instance_b" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_b.id
  key_name                    = var.key_pair
  associate_public_ip_address = true
  security_groups             = [aws_security_group.allow_ssh_b.id]
  lifecycle {
    ignore_changes = [security_groups]
  }
  tags = {
    Name = "tf-instance-b"
  }
}
