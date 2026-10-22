# Creating an S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "tf-s3-test-bucket-2025"
  tags = {
    Name       = "tf-s3"
    Enviroment = "tf-demo"
  }
}

# Uploading Files to S3 Bucket
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "tf-document.txt"
  source = "./tf-document.txt"
}

# Enable versioning on the S3 bucket
# This enables versioning on the S3 bucket, which will keep multiple 
# versions of each object stored in the bucket.
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# create a folder
resource "aws_s3_object" "folder_example" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "my-folder/"
}

# Uploading Files to folder S3 Bucket
resource "aws_s3_object" "my_file_in_folder" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "my_folder/my_file.txt" # This creates the "folder" structure
  source = "./my_file.txt"         # Path to your local file
}

# Provision files using s3_bucket_object
resource "aws_s3_object" "provision_source_files" {
  bucket   = aws_s3_bucket.my_bucket.bucket
  for_each = fileset("app/", "**/*.*")
  key      = each.value
  source   = "uploads/${each.value}"
}
