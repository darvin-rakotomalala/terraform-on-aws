output "instance_public_ip" {
  description = "The public IP address assigned to the web server instance."
  value       = aws_instance.web_server.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.web_server.id
}

output "volume_id" {
  description = "The ID of the created EBS volume"
  value       = aws_ebs_volume.ebs-volume-1.id
}

output "volume_arn" {
  description = "The ARN of the created EBS volume"
  value       = aws_ebs_volume.ebs-volume-1.arn
}

output "volume_tags" {
  description = "The tags assigned to the volume"
  value       = aws_ebs_volume.ebs-volume-1.tags
}
