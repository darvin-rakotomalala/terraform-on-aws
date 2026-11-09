resource "aws_vpc" "CustomVPC" {
  cidr_block           = "18.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "tf-CustomVPC"
  }
}
