/*
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # S3 backend configuration
  backend "s3" {
    bucket  = "BUCKETNAME_TO_BE_REPLACED"
    key     = "api-lambda/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
*/