output "public_ip" {
  description = "The public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

output "volume_id" {
  value = aws_ebs_volume.ebs_vol.id
}
