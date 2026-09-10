# Create S3 and DynamoDB Resources
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "my-tf-state-69127"
  force_destroy = true
  tags = {
    Project = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_lock_table" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key = "LockID"
  tags = {
    Project = "Terraform"
  }
}

# First Apply (Without Backend Configuration)

# Configure the Backend
terraform {
  backend "s3" {
    bucket         = "my-tf-state-69127"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = false
  }
}
