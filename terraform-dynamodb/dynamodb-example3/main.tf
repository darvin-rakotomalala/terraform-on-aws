# Creating the DynamoDB Table
/*
  Remember, on-demand billing is ideal for workloads with unpredictable traffic, 
  as you only pay for the read/write operations you use.
*/
resource "aws_dynamodb_table" "cars" {
  name         = "car"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "vin"
  attribute {
    name = "vin"
    type = "S"
  }
}

# Inserting Items into the Table
resource "aws_dynamodb_table_item" "car_items" {
  table_name = aws_dynamodb_table.cars.name
  hash_key   = aws_dynamodb_table.cars.hash_key
  item       = <<EOF
    {
      "manufacturer": {"S": "Toyota"},
      "make": {"S": "Corolla"},
      "year": {"N": "2004"},
      "vin": {"S": "4Y1SL65848Z411439"}
    }
    EOF
}
