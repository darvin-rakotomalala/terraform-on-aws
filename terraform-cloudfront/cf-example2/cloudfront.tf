// create the cloudfront distribution
resource "aws_cloudfront_distribution" "static_website_distribution" {
  enabled             = true
  default_root_object = "index.html" // set this to be the webpage html file in order to render page when accessing distribution through link
  is_ipv6_enabled     = true
  wait_for_deployment = true

  //setup caching for your cloudfront distribution
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    target_origin_id       = "s3_origin"         // Use a unique ID for the origin defined in the origin section below
    viewer_protocol_policy = "redirect-to-https" // redirect http to https
  }

  // set your s3 bucket as the origin i.e. what your cloudfront distribution interacts with
  origin {
    domain_name              = aws_s3_bucket.static_website_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id // add your created origin access control
    origin_id                = "s3_origin"                                 # Use a unique ID for the origin
  }

  restrictions {
    geo_restriction {
      restriction_type = "none" //manipulate to restrict access to your resource based on location
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

// Create your origin access control to enable access to private S3 bucket
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "s3_static_website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
