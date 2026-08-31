// Create static-site hosting bucket
resource "aws_s3_bucket" "landing_page_bucket" {
  bucket = "cf-route53-69127-${var.environment}"

  tags = {
    Name        = "landing-page"
    Environment = var.environment
  }
}

// allow public access
resource "aws_s3_bucket_public_access_block" "landing_page_public_access" {
  bucket = aws_s3_bucket.landing_page_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// enable static-site hosting
resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.landing_page_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

##### will upload all the files present under HTML folder to the S3 bucket #####
resource "aws_s3_object" "upload_object" {
  for_each     = fileset("html/", "*")
  bucket       = aws_s3_bucket.landing_page_bucket.id
  key          = each.value
  source       = "html/${each.value}"
  etag         = filemd5("html/${each.value}")
  content_type = "text/html"
}

# Apply Bucket Policy
resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.landing_page_bucket.id
  policy = data.aws_iam_policy_document.iam-policy-1.json
}

data "aws_iam_policy_document" "iam-policy-1" {
  statement {
    sid    = "AllowPublicRead"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.landing_page_bucket.id}",
      "arn:aws:s3:::${aws_s3_bucket.landing_page_bucket.id}/*",
    ]
    actions = ["s3:GetObject"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
  depends_on = [aws_s3_bucket_public_access_block.landing_page_public_access]
}
