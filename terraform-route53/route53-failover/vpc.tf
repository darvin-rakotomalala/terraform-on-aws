#--main/root--

data "aws_availability_zone" "dedicateaz" {
  name = "us-east-1a"
}

resource "aws_vpc" "dns_env" {
  cidr_block           = cidrsubnet("18.0.0.0/20", 3, var.region_number[data.aws_availability_zone.dedicateaz.region])
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dnsenv"
  }
}

resource "aws_subnet" "pub_dns" {
  vpc_id                  = aws_vpc.dns_env.id
  cidr_block              = cidrsubnet(aws_vpc.dns_env.cidr_block, 1, var.az_number[data.aws_availability_zone.dedicateaz.name_suffix])
  map_public_ip_on_launch = false

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "webig" {
  vpc_id = aws_vpc.dns_env.id

  tags = {
    Name = "web-igw"
  }
}

resource "aws_route_table" "dnsenv_rt" {
  vpc_id = aws_vpc.dns_env.id
}

resource "aws_route" "rt_route" {
  route_table_id         = aws_route_table.dnsenv_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.webig.id
}

resource "aws_route_table_association" "rt_pub_access" {
  route_table_id = aws_route_table.dnsenv_rt.id
  subnet_id      = aws_subnet.pub_dns.id
}

resource "aws_eip" "webeip" {
  domain = "vpc"

  tags = {
    Name = "mywebec2-eip"
  }
}

resource "aws_eip_association" "webeip_assoc" {
  instance_id   = aws_instance.myweb.id
  allocation_id = aws_eip.webeip.id
}
