data "aws_s3_bucket" "s3_primary" {
  bucket = var.s3_primary_bucket_id
}

data "aws_s3_bucket" "s3_failover" {
  bucket = var.s3_failover_bucket_id
}

####################################################
# Create AWS Cloudfront distribution
####################################################
resource "aws_cloudfront_origin_access_control" "cf-s3-oac" {
  name                              = "CloudFront S3 OAC"
  description                       = "CloudFront S3 OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cf-dist" {
  enabled             = true
  default_root_object = "index.html"

  origin_group {
    origin_id = "origin_group_id"
    failover_criteria {
      status_codes = [403, 404, 500, 502, 503, 504]
    }
    member {
      origin_id = "s3_primary"
    }
    member {
      origin_id = "s3_failover"
    }
  }

  origin {
    domain_name              = data.aws_s3_bucket.s3_primary.bucket_regional_domain_name
    origin_id                = "s3_primary"
    origin_access_control_id = aws_cloudfront_origin_access_control.cf-s3-oac.id
  }

  origin {
    domain_name              = data.aws_s3_bucket.s3_failover.bucket_regional_domain_name
    origin_id                = "s3_failover"
    origin_access_control_id = aws_cloudfront_origin_access_control.cf-s3-oac.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "origin_group_id"
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 360
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN", "US", "CA"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-cloudfront"
  })
}
