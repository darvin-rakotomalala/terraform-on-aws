resource "aws_vpc" "productionvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "tf-demo-vpc"
  }
}
