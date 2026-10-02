# Data sources to get current account ID and region for the policy
data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "aws_region" "current" {}
