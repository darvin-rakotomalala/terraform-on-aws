# AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

# =============================================================================
# Providers - Multi-Region Setup
# =============================================================================
# =============================================================================
# Providers - Multi-Region Setup
# =============================================================================

provider "aws" {
  region = "us-east-1"
  alias  = "primary"

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  alias  = "secondary"

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
