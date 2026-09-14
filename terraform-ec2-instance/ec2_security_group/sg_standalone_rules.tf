# Convert inline security group rules to standalone rules
/*
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "web_server_sg_tf" {
  name        = "demo-tf-sg"
  description = "Allow SHH on port 22 and HTTP/HTTPS access on port 80/443"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "demo-tf-sg"
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  description       = "Allow SSH from VPC"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server_sg_tf.id
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  description       = "Allow HTTP from VPC"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server_sg_tf.id
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  description       = "Allow HTTPS from VPC"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server_sg_tf.id
}

resource "aws_security_group_rule" "allow_all" {
  type              = "ingress"
  description       = "allow all from VPC"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server_sg_tf.id
}
*/