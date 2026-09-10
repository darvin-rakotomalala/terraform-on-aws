output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform_state.id
  description = "The name of the S3 bucket"
}

output "table_arn" {
  value       = aws_dynamodb_table.terraform_lock_table.name
  description = "DynamoDB Table created successfully"
}
