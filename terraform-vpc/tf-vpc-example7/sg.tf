# create a new security group
resource "aws_security_group" "terrafrom_sg" {
  name        = "Tf-sg"
  description = "SG for to allow ssh"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "tf-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.terrafrom_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  # cidr_ipv4         = var.MYIP
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terrafrom_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
