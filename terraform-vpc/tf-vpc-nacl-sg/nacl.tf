# public_subnets_cidr
variable "public_subnets_cidr" {
  type        = string
  default     = "18.0.93.0/24"
  description = "CIDR block for Public Subnet"
}

resource "aws_network_acl" "aws_nacl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.PublicSubnet1.id, aws_subnet.PublicSubnet2.id]

  # allow ingress port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.public_subnets_cidr
    from_port  = 22
    to_port    = 22
  }

  # allow ingress port 80 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.public_subnets_cidr
    from_port  = 80
    to_port    = 80
  }

  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.public_subnets_cidr
    from_port  = 1024
    to_port    = 65535
  }

  # allow egress port 22 
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.public_subnets_cidr
    from_port  = 22
    to_port    = 22
  }

  # allow egress port 80 
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.public_subnets_cidr
    from_port  = 80
    to_port    = 80
  }

  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.public_subnets_cidr
    from_port  = 1024
    to_port    = 65535
  }
  tags = {
    Name = "tf-CustomNACL"
  }
}
