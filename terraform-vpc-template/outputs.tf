output "PublicIP" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.project_front_end_1a.public_ip
}

output "PublicIP2" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.project_front_end_1b.public_ip
}

output "ALB_DNS" {
  description = "The ALBs DNS"
  value       = aws_lb.project_lb.dns_name
}

output "RDS_DNS" {
  description = "The RDS DNS"
  value       = aws_db_instance.project.address
}
