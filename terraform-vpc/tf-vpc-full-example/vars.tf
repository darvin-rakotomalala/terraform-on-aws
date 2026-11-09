variable "aws_region" {
  default = "us-east-1"
}

variable "environment" {
  default = "tf-demo"
}

variable "vpc_cidr" {
  default     = "18.0.0.0/16"
  description = "CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list(any)
  default     = ["18.0.0.0/24", "18.0.128.0/24"]
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  default     = ["18.0.16.0/24", "18.0.144.0/24"]
  description = "CIDR block for Private Subnet"
}
