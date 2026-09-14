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
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-tf-sg"
  }

}
