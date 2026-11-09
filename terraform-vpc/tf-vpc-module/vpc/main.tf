# vpc/main.tf
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "public" {
  count      = length(var.subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[count.index]
  tags = {
    Name = "tf-pub-sub-${count.index}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "tf-igw"
  }
}
