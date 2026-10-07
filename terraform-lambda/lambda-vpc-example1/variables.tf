variable "region" {
  type        = string
  description = "AWS region to use for resources."
  default     = "us-east-1"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR block"
  default     = "18.0.0.0/16"
}

variable "stage" {
  type        = string
  description = "Environnement stage."
  default     = "dev"
}

variable "func_name" {
  type        = string
  description = "Lambda Function name."
  default     = "my-lambda-func"
}
