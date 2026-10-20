resource "aws_s3_object" "object-upload" {
  bucket       = data.aws_s3_bucket.selected-bucket.bucket
  for_each     = fileset("uploads/", "*")
  key          = each.value
  source       = "uploads/${each.value}"
  etag         = filemd5("uploads/${each.value}")
  content_type = "text/html"
}
