variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for all resources"
}

variable "bucket_name" {
  type        = string
  default     = "my-cf-demo-69127"
  description = "Globally unique S3 bucket name"
}
