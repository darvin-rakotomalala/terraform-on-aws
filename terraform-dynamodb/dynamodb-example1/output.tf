output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.dynamodb_table.name
}

output "table_arn" {
  value       = aws_dynamodb_table.dynamodb_table.arn
  description = "DynamoDB Table created successfully"
}
