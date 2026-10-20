resource "aws_instance" "Bastion" {
  ami               = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "my-key-pair"
  tenancy           = "default"
  subnet_id         = aws_subnet.VPC_A_Public_Subnet_A.id
  security_groups   = ["${aws_security_group.SG_bastion.id}"]
  tags = {
    Name = "Bastion_host_Instance_A"
  }
}

resource "aws_instance" "VPC_A_Private_Subnet_A_Instance_A" {
  ami               = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "my-key-pair"
  tenancy           = "default"
  subnet_id         = aws_subnet.VPC_A_Private_Subnet_A.id
  security_groups   = ["${aws_security_group.SG_Private.id}"]

  tags = {
    Name = "Private_Subnet_A_Instance_A"
  }
}
