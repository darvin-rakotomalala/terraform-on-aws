# DynamoDB Tables
resource "aws_dynamodb_table" "my_dynamodb_table" {
  name         = "MyS3EventData"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id" # Example primary key

  attribute {
    name = "id"
    type = "S"
  }
}
