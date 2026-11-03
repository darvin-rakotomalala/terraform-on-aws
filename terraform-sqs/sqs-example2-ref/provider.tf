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
  region = "us-east-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
}

provider "aws" {
  alias  = "secondary"
  region = "us-east-2"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_organizations_organization" "myorg" {}
