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

# Secondary Provider (Secondary/Alias)
provider "aws" {
  alias  = "dr_region"
  region = "us-west-2"
}
