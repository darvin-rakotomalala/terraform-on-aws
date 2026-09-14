# default VPC
data "aws_vpc" "default" {
  default = true
}

# create security group for the app server
resource "aws_security_group" "web_server_sg_tf" {
  name        = "demo-tf-sg"
  description = "Allow SHH on port 22 and HTTP access on port 80"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-tf-sg"
  }

}
