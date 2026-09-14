# default VPC
data "aws_vpc" "default" {
  default = true
}

# create security group for the app server
resource "aws_security_group" "web_server_sg_tf" {
  name        = "demo-tf-sg"
  description = "Allow SHH on port 22 and HTTP/HTTPS access on port 80/443"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-tf-sg"
  }

}

# START - Use existing security groups
variable "security_group_id" {
  type    = string
  default = "sg-0cfaf91c159766898"
}

data "aws_security_group" "selected" {
  id = var.security_group_id
}

resource "aws_security_group_rule" "allow_ssh_from_vpc" {
  type              = "ingress"
  description       = "Allow SSH from VPC"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.default.cidr_block]
  security_group_id = data.aws_security_group.selected.id
}

resource "aws_security_group_rule" "allow_http_from_vpc" {
  type              = "ingress"
  description       = "Allow HTTP from VPC"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.default.cidr_block]
  security_group_id = data.aws_security_group.selected.id
}

resource "aws_security_group_rule" "allow_https_from_vpc" {
  type              = "ingress"
  description       = "Allow HTTPS from VPC"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.default.cidr_block]
  security_group_id = data.aws_security_group.selected.id
}
# END - Use existing security groups
