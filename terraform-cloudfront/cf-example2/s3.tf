resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "cloudfront-example-2025" //s3 bucket name, needs to be unique
  force_destroy = true
  tags = {
    Project = "cf-demo"
  }
}

resource "aws_s3_bucket_website_configuration" "blog" {
  bucket = aws_s3_bucket.static_website_bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.static_website_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Will upload all the files present under HTML folder to the S3 bucket
/*
resource "aws_s3_object" "index" {
  for_each     = fileset("html/", "*")
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = each.value
  source       = "html/${each.value}"
  etag         = filemd5("html/${each.value}")
  content_type = "text/html"
}
*/

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_website_bucket.bucket
  key          = "index.html"
  source       = "./html/index.html"
  content_type = "text/html" # Set Content-Type to text/html
  etag         = filemd5("./html/index.html")
}

resource "aws_s3_object" "css" {
  bucket       = aws_s3_bucket.static_website_bucket.bucket
  key          = "index.css"
  source       = "./html/index.css"
  content_type = "text/css" # Set Content-Type to text/css
  etag         = filemd5("./html/index.css")
}

resource "null_resource" "sync_assets" {
  //upload all files in assets folder
  provisioner "local-exec" {
    command = "aws s3 sync ./html/assets s3://${aws_s3_bucket.static_website_bucket.bucket}/assets"
  }
}

data "aws_iam_policy_document" "cloudfront_policy" {
  statement {
    sid    = "AllowCloudFrontServicePrincipal"
    effect = "Allow"

    // give bucket access to CloudFront
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.static_website_bucket.arn}/*"]

    // restrict CloudFront access to your distribution only
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.static_website_distribution.arn]
    }
  }
  depends_on = [aws_cloudfront_distribution.static_website_distribution]
}

// add bucket policy to your S3 bucket
resource "aws_s3_bucket_policy" "cloudfront_policy" {
  bucket = aws_s3_bucket.static_website_bucket.id
  policy = data.aws_iam_policy_document.cloudfront_policy.json
}
