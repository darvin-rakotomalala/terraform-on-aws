# Create a subnet inside the VPC
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "18.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-public-subnet"
  }
}
