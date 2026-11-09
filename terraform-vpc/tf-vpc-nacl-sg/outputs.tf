output "NACL" {
  value       = aws_network_acl.aws_nacl.id
  description = "A reference to the created NACL"
}

output "SID" {
  value       = aws_security_group.ec2_sg.id
  description = "A reference to the created NACL Inbound Rule"
}

output "PublicSubnet1" {
  value       = aws_subnet.PublicSubnet1.id
  description = "This is first public subnet id."
}

output "PublicSubnet2" {
  value       = aws_subnet.PublicSubnet2.id
  description = "This is first second subnet id."
}
