### --- dynamodb/resources.tf ---

resource "aws_dynamodb_table" "sneakers_table" {
  name           = var.table_name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "BrandName"
  range_key      = "ModelNumber"

  attribute {
    name = "BrandName"
    type = "S"
  }

  attribute {
    name = "ModelNumber"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name            = "Sneakers_GSI"
    hash_key        = "BrandName"
    range_key       = "ModelNumber"
    write_capacity  = 10
    read_capacity   = 10
    projection_type = "ALL"
  }

  tags = {
    Name        = var.environment_name
    Environment = var.environment_type
  }
}

# Resource: aws_dynamodb_table_item
resource "aws_dynamodb_table" "example" {
  name           = "example_name"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "exampleHashKey"

  attribute {
    name = "exampleHashKey"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "example" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = aws_dynamodb_table.example.hash_key

  item = <<ITEM
        {
            "exampleHashKey": {"S": "something"},
            "one": {"N": "11111"},
            "two": {"N": "22222"},
            "three": {"N": "33333"},
            "four": {"N": "44444"}
        }
    ITEM
}
