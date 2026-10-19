# outputs.tf
output "db_instance_endpoint" {
  value = aws_db_instance.myinstance.endpoint
}

output "security_group_id" {
  value = aws_security_group.allow_mysql_traffic.id
}
