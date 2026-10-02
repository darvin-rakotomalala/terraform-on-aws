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

provider "aws" {
  alias  = "secondary"
  region = "us-east-2"
}

provider "aws" {
  alias                  = "tertiary"
  region                 = "us-west-1"
  skip_region_validation = true
}
