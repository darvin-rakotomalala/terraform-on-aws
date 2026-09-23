resource "aws_vpc" "test-env" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "subnet-efs" {
  cidr_block        = cidrsubnet(aws_vpc.test-env.cidr_block, 8, 8)
  vpc_id            = aws_vpc.test-env.id
  availability_zone = "us-east-1a"
}
