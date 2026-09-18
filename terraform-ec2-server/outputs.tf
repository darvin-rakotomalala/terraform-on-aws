output "instance_id" {
  value       = module.web.instance_id
  description = "Instance ID of Web Server"
}

output "public_ip" {
  value       = "http://${module.web.public_ip}/"
  description = "Public IP of Web Server"
}
