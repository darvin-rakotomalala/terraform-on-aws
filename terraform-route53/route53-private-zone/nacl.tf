
# Create a first NACL for the first subnet
resource "aws_network_acl" "VPC_A_Public_NACL_A" {
  vpc_id     = aws_vpc.VPC_A.id
  subnet_ids = [aws_subnet.VPC_A_Public_Subnet_A.id]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    "name" = "VPC_A_Public_NACL_A"
  }
}

resource "aws_network_acl_association" "VPC_A_Public_NACL_A_Association" {
  network_acl_id = aws_network_acl.VPC_A_Public_NACL_A.id
  subnet_id      = aws_subnet.VPC_A_Public_Subnet_A.id
}

resource "aws_network_acl" "VPC_A_Private_NACL_A" {
  vpc_id     = aws_vpc.VPC_A.id
  subnet_ids = [aws_subnet.VPC_A_Private_Subnet_A.id]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    "name" = "VPC_A_Private_NACL_A"
  }
}

resource "aws_network_acl_association" "VPC_A_Private_NACL_A_Association" {
  network_acl_id = aws_network_acl.VPC_A_Private_NACL_A.id
  subnet_id      = aws_subnet.VPC_A_Private_Subnet_A.id
}
