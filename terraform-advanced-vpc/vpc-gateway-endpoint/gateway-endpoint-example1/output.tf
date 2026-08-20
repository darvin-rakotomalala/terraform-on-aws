# outputs.tf
output "instance_public_dns" {
  description = "The public DNS name of the public web server instance."
  value       = aws_instance.BASTION_HOST.public_dns
}

output "public_instance_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.BASTION_HOST.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.private_ec2.private_ip
}

output "gateway_endpoint_service_name" {
  description = "The service name of the VPC Gateway Endpoint."
  value       = aws_vpc_endpoint.gateway_endpoint.service_name
}
