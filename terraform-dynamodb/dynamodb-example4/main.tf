# Provisioning the DynamoDB Table
resource "aws_dynamodb_table" "tf_notes_table" {
  name           = "tf_note_table"
  billing_mode   = "PROVISIONED"
  read_capacity  = "30"
  write_capacity = "30"
  attribute {
    name = "noteId"
    type = "S"
  }
  hash_key = "noteId"

  ttl {
    // enabling TTL (Time To Live)
    enabled = true
    // the attribute name which enforces  TTL, must be a Number (Timestamp)
    attribute_name = "expiryPeriod"
  }

  // configuring Point in Time Recovery 
  point_in_time_recovery {
    enabled = true
  }

  // configure Encryption at REST
  server_side_encryption {
    enabled = true
    // false -> use AWS Owned CMK 
    // true -> use AWS Managed CMK 
    // true + key arn -> use custom key
  }

  lifecycle {
    ignore_changes = [
      read_capacity, write_capacity
    ]
  }
}

# Auto-Scaling
module "table_autoscaling" {
  source     = "snowplow-devops/dynamodb-autoscaling/aws" // add the autoscaling module
  table_name = aws_dynamodb_table.tf_notes_table.name     // apply autoscaling for the tf_notes_table
}

# State Locking in Terraform
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tf-state-backend-69127"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform-lock" {
  name           = "terraform_state"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

/*
  terraform {
    backend "s3" {
      bucket = "tf-state-backend-69127"
      key = "terraform.tfstate"
      region = "us-east-1"
      dynamodb_table = "terraform_state"
    }
  }
*/
