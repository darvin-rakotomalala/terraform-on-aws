################################################################################
# S3 Source Image Bucket
################################################################################
resource "aws_s3_bucket" "source-image-bucket" {
  bucket = var.source_bucket_name
  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-s3-source-bucket"
  })
}
