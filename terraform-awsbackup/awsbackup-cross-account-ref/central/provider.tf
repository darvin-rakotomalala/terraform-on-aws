# AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

# Primary Provider (Default)
provider "aws" {
  region = "us-east-1"
}
