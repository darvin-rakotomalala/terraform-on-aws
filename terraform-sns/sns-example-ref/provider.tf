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
}

# Configure the secondary AWS provider
provider "aws" {
  alias  = "secondary_region"
  region = "us-east-2"
}
