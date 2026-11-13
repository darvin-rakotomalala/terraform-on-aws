terraform {
  required_version = ">= 1.14.7" # Terraform v1.14.7 or greater, but less than v2.0.0.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Locks to 6.x, prevents 7.0
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "primary"
}
