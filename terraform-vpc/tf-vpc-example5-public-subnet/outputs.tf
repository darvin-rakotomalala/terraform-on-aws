output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.tf_pub_sub.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.tf_igw.id
}

output "instance_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}

output "sg_ip" {
  value = aws_security_group.ec2_sg.id
}
