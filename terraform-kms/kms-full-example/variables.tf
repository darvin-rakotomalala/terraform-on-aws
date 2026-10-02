# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "vpc_cidr" {
  default = "18.0.0.0/16"
}

variable "access_cidr" {
  default = "0.0.0.0/0"
}

variable "subnet_count" {
  default = 2
}

variable "public_cidrs" {
  type    = list(any)
  default = ["18.0.1.0/24", "18.0.2.0/24"]
}

variable "private_cidrs" {
  type    = list(any)
  default = ["18.0.3.0/24", "18.0.4.0/24"]
}

variable "availability_zone" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "demo-kms"
}

variable "db_name" {
  description = "Project name"
  type        = string
  default     = "demokms"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "allowed_role_arns" {
  description = "List of IAM role ARNs allowed to use the key"
  type        = list(string)
  default     = []
}

variable "trusted_account_arns" {
  description = "List of IAM role ARNs allowed to use the key"
  type        = list(string)
  default     = []
}
