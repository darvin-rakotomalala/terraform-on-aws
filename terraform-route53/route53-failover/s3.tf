# The bucket's name in S3 should be exactly your domain name (e.g. example.com or www.example.com).
resource "aws_s3_bucket" "dns_bucket" {
  bucket        = var.bucketName
  force_destroy = true
  tags = {
    Name = "stacticweb"
  }
}

resource "aws_s3_bucket_website_configuration" "blog" {
  bucket = aws_s3_bucket.dns_bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.dns_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

##### will upload all the files present under s3file folder to the S3 bucket #####
resource "aws_s3_object" "upload_object" {
  for_each     = fileset("s3file/", "*")
  bucket       = aws_s3_bucket.dns_bucket.id
  key          = each.value
  source       = "s3file/${each.value}"
  etag         = filemd5("s3file/${each.value}")
  content_type = "text/html"
}

# Apply Bucket Policy
resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.dns_bucket.id
  policy = data.aws_iam_policy_document.iam-policy-1.json
}

data "aws_iam_policy_document" "iam-policy-1" {
  statement {
    sid    = "AllowPublicRead"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.dns_bucket.id}",
      "arn:aws:s3:::${aws_s3_bucket.dns_bucket.id}/*",
    ]
    actions = ["s3:GetObject"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
  depends_on = [aws_s3_bucket_public_access_block.public_access_block]
}
