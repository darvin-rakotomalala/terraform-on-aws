output "private_hosted_zone_id" {
  description = "Zone ID for private hosted zone"
  value       = aws_route53_zone.private_zone.zone_id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.Bastion.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.VPC_A_Private_Subnet_A_Instance_A.private_ip
}
