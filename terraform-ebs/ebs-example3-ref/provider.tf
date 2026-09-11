# AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

# Primary Region Provider
provider "aws" {
  alias  = "primary"
  region = "us-east-1"
}

# Secondary Region Provider
provider "aws" {
  alias  = "secondary"
  region = "us-west-2"
}
