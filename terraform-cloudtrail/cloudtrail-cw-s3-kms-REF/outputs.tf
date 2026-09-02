output "encryption_key_arn" {
  value = aws_kms_key.log_key.arn
}

output "log_bucket_arn" {
  value = aws_s3_bucket.log_bucket.arn
}

output "trail_arn" {
  value = aws_cloudtrail.example.arn
}
