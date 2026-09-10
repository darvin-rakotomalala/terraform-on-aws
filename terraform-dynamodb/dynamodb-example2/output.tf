output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.users.name
}

output "table_arn" {
  value       = aws_dynamodb_table.users.arn
  description = "DynamoDB Table created successfully"
}
