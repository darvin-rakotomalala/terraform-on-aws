output "tf_vpc_id" {
  value = aws_vpc.tf_vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.tf_igw.id
}

output "eip_id" {
  value = aws_eip.nat_eip.id
}

output "natgw_id" {
  value = aws_nat_gateway.tf_natgw.id
}

output "public_sub_id" {
  value = aws_subnet.public_sub.id
}

output "private_sub_id" {
  value = aws_subnet.private_sub.id
}

output "public_rt_id" {
  value = aws_route_table.public_rt.id
}

output "private_rt_id" {
  value = aws_route_table.private_rt.id
}

output "public_sg_id" {
  value = aws_security_group.demo_public_sg.id
}

output "private_sg_id" {
  value = aws_security_group.demo_private_sg.id
}

output "public_ec2_id" {
  value = aws_instance.public_ec2_instance.id
}
