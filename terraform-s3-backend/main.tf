# terraform {
#############################################################
## AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND)
## YOU WILL UNCOMMENT THIS CODE THEN RERUN TERRAFORM INIT
## TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
#############################################################
# backend "s3" {
#   encrypt = true
#   bucket         = "demo-backend-tf-state-202508" # REPLACE WITH YOUR BUCKET NAME
#   key            = "state/terraform.tfstate"
#   region         = "us-east-1"
#   dynamodb_table = "tf-state-locking"
#   use_lockfile   = true
# }
# }

resource "aws_s3_bucket" "tf_state" {
  bucket        = "demo-backend-tf-state-202508" # REPLACE WITH YOUR BUCKET NAME
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "tf_bucket_versioning" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_crypto_conf" {
  bucket = aws_s3_bucket.tf_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "tf-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
