# Create the S3 Bucket and Origin Access
resource "aws_s3_bucket" "static_site_bucket" {
  bucket        = "my-bucket-cf-waf-69127" # Replace with a globally unique name
  force_destroy = true
  tags = {
    Project = "CF-WAF-Demo"
  }
}

resource "aws_s3_bucket_website_configuration" "blog" {
  bucket = aws_s3_bucket.static_site_bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.static_site_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Will upload all the files present under HTML folder to the S3 bucket
resource "aws_s3_object" "upload_object" {
  for_each     = fileset("html/", "*")
  bucket       = aws_s3_bucket.static_site_bucket.id
  key          = each.value
  source       = "html/${each.value}"
  etag         = filemd5("html/${each.value}")
  content_type = "text/html"
}
