# Creating DynamoDB Table
resource "aws_dynamodb_table" "dynamodb_table" {
  name           = "test_table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5

  hash_key = "RollNo"

  attribute {
    name = "RollNo"
    type = "N"
  }
}

# Populating Table with Sample Data
resource "aws_dynamodb_table_item" "item1" {
  table_name = aws_dynamodb_table.dynamodb_table.name
  hash_key   = aws_dynamodb_table.dynamodb_table.hash_key
  item       = <<ITEM
    {
    "RollNo": {"N": "1"},
    "Name": {"S": "Arjun"}
    }
    ITEM
}

resource "aws_dynamodb_table_item" "item2" {
  table_name = aws_dynamodb_table.dynamodb_table.name
  hash_key   = aws_dynamodb_table.dynamodb_table.hash_key
  item       = <<ITEM
    {
    "RollNo": {"N": "2"},
    "Name": {"S": "Nagesh"}
    }
    ITEM
}

resource "aws_dynamodb_table_item" "item3" {
  table_name = aws_dynamodb_table.dynamodb_table.name
  hash_key   = aws_dynamodb_table.dynamodb_table.hash_key
  item       = <<ITEM
    {
    "RollNo": {"N": "3"},
    "Name": {"S": "Nagarjun"}
    }
    ITEM
}
