# DynamoDB table resource
resource "aws_dynamodb_table" "users" {
  name           = "user_table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 5

  hash_key = "user_id" # primary key

  attribute {
    name = "user_id"
    type = "S" # String data type
  }

  attribute {
    name = "email"
    type = "S"
  }

  attribute {
    name = "user_name"
    type = "S"
  }

  lifecycle {
    prevent_destroy = false # prevent destroy, this rule helps safeguard critical resources from accidental deletion.
  }

  # add indexes
  global_secondary_index {
    name               = "user_email_index" # Name for your GSI
    hash_key           = "email"            # Attribute for GSI hash key
    range_key          = "user_name"        # Optional range key for GSI (can be omitted)
    read_capacity      = 10
    write_capacity     = 5
    projection_type    = "ALL" # Corrected projection_type
    non_key_attributes = []
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    Name        = "user_table"
    Environment = "Training"
  }

  stream_enabled   = true                 # enable streams
  stream_view_type = "NEW_AND_OLD_IMAGES" # Change to KEYS_ONLY or NEW_IMAGE or OLD_IMAGE or NEW_AND_OLD_IMAGES for different stream view types
}

# tables and items
resource "aws_dynamodb_table_item" "user_item" {
  table_name = aws_dynamodb_table.users.name
  hash_key   = "user_id"
  item = jsonencode({
    user_id   = { S = "user123" },
    user_name = { S = "Tojo Darvin" },
    email     = { S = "terraform_user@example.com" }
    # Add more attributes as needed
  })
}

# Example configuring state locking
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform_state_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
