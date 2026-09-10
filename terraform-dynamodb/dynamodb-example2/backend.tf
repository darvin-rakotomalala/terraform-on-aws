/*
terraform {
 backend "s3" {
   bucket         = "your-terraform-state-bucket"
   key            = "your-state-file-key"
   dynamodb_table = "terraform_state_lock"  # Enable state locking
 }
}
*/
