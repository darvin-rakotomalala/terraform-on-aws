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
  region  = var.region
  # profile = var.profile
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
