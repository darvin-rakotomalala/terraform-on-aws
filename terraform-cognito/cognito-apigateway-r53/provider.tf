# AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

# Configure the primary AWS provider
provider "aws" {
  region = "us-east-1" # ACM certificates for CloudFront (edge-optimized) must be in us-east-1
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
}
