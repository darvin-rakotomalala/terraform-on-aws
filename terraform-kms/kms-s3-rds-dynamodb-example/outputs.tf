# Output the bucket name
output "bucket_name" {
  value = aws_s3_bucket.secure_bucket.id
}

output "s3_kms_key_id" {
  value = aws_kms_key.s3_key.id
}

output "dynamodb_kms_key_id" {
  value = aws_kms_key.dynamodb_key.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.encrypted_table.name
}
