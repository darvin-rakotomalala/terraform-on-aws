resource "aws_kms_key" "dynamodb_key" {
  description             = "KMS key for encrypting DynamoDB tables"
  deletion_window_in_days = 7
  enable_key_rotation     = true # Optional: enable automatic key rotation
}

# Create an alias for the KMS key
resource "aws_kms_alias" "dynamodb_key_alias" {
  # The alias name must always start with the "alias/" prefix
  name          = "alias/my-dynamodb-key"
  target_key_id = aws_kms_key.dynamodb_key.key_id
}

resource "aws_dynamodb_table" "encrypted_table" {
  name         = "MyEncryptedTable"
  billing_mode = "PAY_PER_REQUEST" # Or PROVISIONED
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  # Configure server-side encryption with the customer-managed KMS key
  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.dynamodb_key.arn
  }

  # Add other table configurations as needed, e.g., range_key, global/local secondary indexes, etc.
}
