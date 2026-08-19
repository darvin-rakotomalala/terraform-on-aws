# AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
}

# Provider for us-east-1 (required for CloudFront resources)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
